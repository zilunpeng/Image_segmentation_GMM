close all
clear all

Img_kangaroo = imread('69020.jpg'); r_channel = Img_kangaroo(:,:,1); g_channel = Img_kangaroo(:,:,2); b_channel = Img_kangaroo(:,:,3);
Img_kangaroo_rgb = [r_channel(:) g_channel(:) b_channel(:)];
Img_kangaroo_lab = rgb2lab(Img_kangaroo); a_channel = Img_kangaroo_lab(:,:,2); b_channel = Img_kangaroo_lab(:,:,3);
Img_kangaroo_ab = [a_channel(:) b_channel(:)];
Img_kangaroo_gray = rgb2gray(Img_kangaroo); Img_kangaroo_gray  = Img_kangaroo_gray(:);
Img_kangaroo_rgb = double(Img_kangaroo_rgb); Img_kangaroo_ab = double(Img_kangaroo_ab); Img_kangaroo_gray = double(Img_kangaroo_gray);

%% Segment the kangaroo image with 2 components using ab channels
[segmented_img,~,~] = gmm(2,Img_kangaroo_ab,size(a_channel));
figure(1); imshow(color_segmented_img(segmented_img,2,size(a_channel)),[0,255]); title('2 clusters LAB')

%% Segment the kangaroo image with 4 components using ab channels
[segmented_img,~,~] = gmm(4,Img_kangaroo_ab,size(a_channel));
figure(2); imshow(color_segmented_img(segmented_img,4,size(a_channel)),[0,255]); title('4 clusters LAB')

%% Segment the kangaroo image with 6 components using ab channels
[segmented_img,~,~] = gmm(6,Img_kangaroo_ab,size(a_channel));
figure(3); imshow(color_segmented_img(segmented_img,6,size(a_channel)),[0,255]); title('6 clusters LAB')

%% Segment the kangaroo image with 2 components using intensity
[segmented_img,~,~] = gmm(2,Img_kangaroo_gray,size(a_channel));
figure(4); imshow(color_segmented_img(segmented_img,2,size(a_channel)),[0,255]); title('2 clusters intensity')

%% Segment the kangaroo image with 4 components using intensity
[segmented_img,~,~] = gmm(4,Img_kangaroo_gray,size(a_channel));
figure(5); imshow(color_segmented_img(segmented_img,4,size(a_channel)),[0,255]); title('4 clusters intensity')

%% Segment the kangaroo image with 6 components using intensity
[segmented_img,~,~] = gmm(6,Img_kangaroo_gray,size(a_channel));
figure(6); imshow(color_segmented_img(segmented_img,6,size(a_channel)),[0,255]); title('6 clusters intensity')

%% Segment the kangaroo image with 2 components using RGB
[segmented_img,~,~] = gmm(2,Img_kangaroo_rgb,size(a_channel));
figure(7); imshow(color_segmented_img(segmented_img,2,size(a_channel)),[0,255]); title('2 clusters RGB')

%% Segment the kangaroo image with 4 components using RGB
[segmented_img,~,~] = gmm(4,Img_kangaroo_rgb,size(a_channel));
figure(8); imshow(color_segmented_img(segmented_img,4,size(a_channel)),[0,255]); title('4 clusters RGB')

%% Segment the kangaroo image with 6 components using RGB
[segmented_img,~,~] = gmm(6,Img_kangaroo_rgb,size(a_channel));
figure(9); imshow(color_segmented_img(segmented_img,6,size(a_channel)),[0,255]); title('6 clusters RGB')

%% other images
Img_227092 = imread('227092.jpg');  r_channel = Img_227092(:,:,1); g_channel = Img_227092(:,:,2); b_channel = Img_227092(:,:,3);
Img_227092_rgb = [r_channel(:) g_channel(:) b_channel(:)];
Img_227092_rgb = double(Img_227092_rgb);

[segmented_img,~,~] = gmm(2,Img_227092_rgb,size(a_channel));
figure(10); imshow(color_segmented_img(segmented_img,2,size(g_channel)),[0,255]); title('2 clusters RGB')

Img_260058 = imread('260058.jpg');  r_channel = Img_260058(:,:,1); g_channel = Img_260058(:,:,2); b_channel = Img_260058(:,:,3);
Img_260058_rgb = [r_channel(:) g_channel(:) b_channel(:)];
Img_260058_rgb = double(Img_260058_rgb);

[segmented_img,~,~] = gmm(2,Img_260058_rgb,size(a_channel));
figure(11); imshow(color_segmented_img(segmented_img,2,size(g_channel)),[0,255]); title('2 clusters RGB')