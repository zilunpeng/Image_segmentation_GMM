function [labeled_img,sum_lld,params] = gmm(K,img,orginal_img_size)
    %%Initialize EM parameters randomly
    [num_px, num_cls] = size(img);
    means=zeros(K,num_cls); variances=zeros(num_cls,num_cls,K);
    for k=1:K
       for i=1:num_cls
          means(k,i) = (max(img(:,i))-min(img(:,i)))*rand+min(img(:,i));
       end
       variances(:,:,k) = (1/num_px)*(img-means(k,:))'*(img-means(k,:));
    end
    alpha = rand(K, 1);
    y = randsample(K, size(img,1), true);
    
    %%Run EM
    posterior = zeros(num_px,K);
    i=0;
    while i<1000
       %E step
       for k=1:K
          likelihood = mvnpdf(img,means(k,:),variances(:,:,k));
          prior = alpha(k,:);
          posterior(:,k) = likelihood.*prior;
       end
       posterior = posterior./sum(posterior,2);
       
       %M step
       means_old = means;
       for k=1:K
           tot_posterior_k = sum(posterior(:,k));
           alpha(k) = tot_posterior_k/num_px;
           variances(:,:,k) = (1/tot_posterior_k)*((img-means(k,:)) .* posterior(:,k))'*(img-means(k,:));
           means(k,:) = (1/tot_posterior_k)*sum(img.*posterior(:,k));
       end
       
       %%debugging
%        fprintf('K=%i, lld=%g\n',K,compute_likelihood(img,alpha,means,variances));
       
       %Stop if means do not change
       if norm(means_old-means) <1e-5
            break
       end
       i=i+1;
    end
    
    %% store parameters
    params.alpha = alpha;
    params.means = means;
    params.variances = variances;
    
    %% Compute likelihood
    sum_lld = compute_likelihood(img,alpha,means,variances);
    
    %% return labeled_img
    [~,labeled_img] = max(posterior,[],2);
end