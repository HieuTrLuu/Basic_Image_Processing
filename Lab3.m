[A,map] =  imread('lenaG.bmp')

[row_n, col_n] = size(A);
gaussian_kernel_10 = fspecial('gaussian',512,10);
gaussian_kernel_20 = fspecial('gaussian',512,10);
subplot(1,2,1);
imshow(imfilter(A,gaussian_kernel_10)); 
subplot(1,2,2)
imshow(imfilter(A,gaussian_kernel_20)); 

noise = randn(row_n,col_n);

A_with_noise = double(A) + noise;

%C4a
conv2(A, A_with_noise);
conv2(A_with_noise, A);

%C6
%5x5, 10x10 and20x20
box5 = fspecial('average', 5);
box10 = fspecial('average', 10);
box20 = fspecial('average', 20);

subplot(1,3,1);
imshow(imfilter(A,box5)); 
subplot(1,3,2)
imshow(imfilter(A,box10)); 
subplot(1,3,3)
imshow(imfilter(A,box20)); 

%C7
img_median3 = medfilt2(A);
img_median5 = medfilt2(A, [5 5]);
img_median7 = medfilt2(A, [7 7]);

subplot(1,3,1);
imshow(img_median3 ); 
subplot(1,3,2)
imshow(img_median5 ); 
subplot(1,3,3)
imshow(img_median7 ); 


