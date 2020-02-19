function sum_lld = compute_likelihood(img,alpha,means,variances)
    K = length(alpha);
    sum_lld = 0;
    for k=1:K
        likelihood = mvnpdf(img,means(k,:),variances(:,:,k));
        prior = alpha(k,:);
        sum_lld = sum_lld + likelihood.*prior;
    end
    sum_lld = sum(log(sum_lld));
end