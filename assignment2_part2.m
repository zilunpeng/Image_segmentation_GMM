close all
clear all

Img_kangaroo = imread('69020.jpg'); r_channel = Img_kangaroo(:,:,1); g_channel = Img_kangaroo(:,:,2); b_channel = Img_kangaroo(:,:,3);
Img_kangaroo_rgb = [r_channel(:) g_channel(:) b_channel(:)];
Img_kangaroo_lab = rgb2lab(Img_kangaroo); a_channel = Img_kangaroo_lab(:,:,2); b_channel = Img_kangaroo_lab(:,:,3);
Img_kangaroo_ab = [a_channel(:) b_channel(:)];
Img_kangaroo_gray = rgb2gray(Img_kangaroo); Img_kangaroo_gray  = Img_kangaroo_gray(:);
Img_kangaroo_rgb = double(Img_kangaroo_rgb); Img_kangaroo_lab = double(Img_kangaroo_lab); Img_kangaroo_gray = double(Img_kangaroo_gray);

%% 5-fold cross validation. Feature space = intensity
num_px = length(Img_kangaroo_gray);
ind_rng = linspace(1,num_px,6);
ind = 1:num_px; 
%ind = ind(randperm(num_px)); 
avg_train_lld_gray = []; avg_val_lld_gray = [];
for k=2:8
    train_lld = 0; 
    val_lld = 0; 
    for i=1:5
        test_ind = ind_rng(i):ind_rng(i+1);
        train_ind = setdiff(ind, test_ind);
        [~,lld,params] = gmm(k,Img_kangaroo_gray(train_ind,:),size(a_channel));
        train_lld = train_lld + lld;
        val_lld = val_lld + compute_likelihood(Img_kangaroo_gray(test_ind,:),params.alpha,params.means,params.variances);
    end
    avg_train_lld_gray = [avg_train_lld_gray train_lld/5]; avg_val_lld_gray = [avg_val_lld_gray val_lld/5];
end
figure(1)
plot([2:8],avg_train_lld_gray); title('average training lld on gray space');
figure(2)
plot([2:8],avg_val_lld_gray); title('average validation lld on gray space');


%% 5-fold cross validation. Feature space = l*a*b
num_px = length(Img_kangaroo_gray);
ind_rng = linspace(1,num_px,6);
ind = 1:num_px; ind = ind(randperm(num_px)); 
avg_train_lld_lab = []; avg_val_lld_lab = [];
for k=2:8
    train_lld = 0; val_lld = 0; 
    for i=1:5
        test_ind = ind_rng(i):ind_rng(i+1);
        train_ind = setdiff(ind, test_ind);
        [~,lld,params] = gmm(k,Img_kangaroo_ab(train_ind,:),size(a_channel));
        train_lld = train_lld + lld;
        val_lld = val_lld + compute_likelihood(Img_kangaroo_ab(test_ind,:),params.alpha,params.means,params.variances);
    end
    avg_train_lld_lab = [avg_train_lld_lab train_lld/5]; avg_val_lld_lab = [avg_val_lld_lab val_lld/5];
end
figure(3)
plot([2:8],avg_train_lld_lab); title('average training lld on l*a*b');
figure(4)
plot([2:8],avg_val_lld_lab); title('average validation lld on l*a*b');

%% 5-fold cross validation. Feature space = RGB
num_px = length(Img_kangaroo_gray);
ind_rng = linspace(1,num_px,6);
ind = 1:num_px; ind = ind(randperm(num_px)); 
avg_train_lld_rgb = []; avg_val_lld_rgb = [];
for k=2:8
    train_lld = 0; val_lld = 0;
    for i=1:5
        test_ind = ind_rng(i):ind_rng(i+1);
        train_ind = setdiff(ind, test_ind);
        [~,lld,params] = gmm(k,Img_kangaroo_rgb(train_ind,:),size(a_channel));
        train_lld = train_lld + lld;
        val_lld = val_lld + compute_likelihood(Img_kangaroo_rgb(test_ind,:),params.alpha,params.means,params.variances);
    end
    avg_train_lld_rgb = [avg_train_lld_rgb train_lld/5]; avg_val_lld_rgb = [avg_val_lld_rgb val_lld/5];
end
figure(5)
plot([2:8],avg_train_lld_rgb); title('average training lld on rgb');
figure(6)
plot([2:8],avg_val_lld_rgb); title('average validation lld on rgb');

%% BIC Feature space = Intensity
bic = [];
for k=2:8
    [~,~,params] = gmm(k,Img_kangaroo_gray,size(a_channel));
    lld = compute_likelihood(Img_kangaroo_gray, params.alpha, params.means, params.variances);
    bic = [bic -2*lld+k*log(num_px)];
end
figure(7)
plot([2:8],bic); title('bic on gray space')

%% BIC Feature space = LAB
bic = [];
for k=2:8
    [~,~,params] = gmm(k,Img_kangaroo_ab,size(a_channel));
    lld = compute_likelihood(Img_kangaroo_ab, params.alpha, params.means, params.variances);
    bic = [bic -2*lld+k*log(num_px)];
end
figure(8)
plot([2:8],bic); title('bic on LAB')

%% BIC Feature space = RGB
bic = [];
for k=2:8
    [~,~,params] = gmm(k,Img_kangaroo_rgb,size(a_channel));
    lld = compute_likelihood(Img_kangaroo_rgb, params.alpha, params.means, params.variances);
    bic = [bic -2*lld+k*log(num_px)];
end
figure(9)
plot([2:8],bic); title('bic on RGB')