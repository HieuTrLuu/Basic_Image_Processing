[A,map] =  imread('lenaG.bmp');
[row_n, col_n] = size(A);
A_wnoise_10 = A + sqrt(10)*randi([-40 40], row_n, 'uint8') + 0;
A_wnoise_20 = A + sqrt(10)*randi([-40 40], row_n, 'uint8') + 0;

uni_noise = repmat(uint8(50),row_n,col_n);

A_uni_noise = A + uni_noise;
colormap('gray');

figure(10),
subplot(1,3,1), imshow(A); title('og Lena');
subplot(1,3,2), imshow(A_wnoise_10); title('Lena with noise (std = 10)');
subplot(1,3,3), imshow(A_wnoise_20); title('Lena with noise (std = 20)');

%C2 + C3
%hartley transform of matrix f
F = fft2(A);
FHT = real(F) - imag(F);


figure(1),
set(gcf, 'Position', get(0,'Screensize')); 
subplot(1,2,1), imshow(dct2(A)); title('DCT2');
subplot(1,2,2), imshow(FHT); title('hartley transform');


%C4a

gaussian_kernel_3 = fspecial('gaussian',512,3);
gaussian_kernel_5 = fspecial('gaussian',512,5);
gaussian_kernel_10 = fspecial('gaussian',512,10);
gaussian_kernel_20 = fspecial('gaussian',512,20);
figure(2),
subplot(2,5,1), imshow(A_wnoise_20); title('Lena with noise (std = 20)');
subplot(2,5,2),imshow(imfilter(A_wnoise_20  ,gaussian_kernel_3)); title('gaussian blurr with std = 3'); 
subplot(2,5,3), imshow(imfilter(A_wnoise_20 ,gaussian_kernel_5)); title('gaussian blurr with std = 5'); 
subplot(2,5,4),imshow(imfilter(A_wnoise_20 ,gaussian_kernel_10)); title('gaussian blurr with std = 10'); 
subplot(2,5,5), imshow(imfilter(A_wnoise_20 ,gaussian_kernel_20)); title('gaussian blurr with std = 20'); 

subplot(2,5,6), imshow(A_uni_noise); title('Lena with noise (std = 20)');
subplot(2,5,7),imshow(imfilter(A_uni_noise  ,gaussian_kernel_3)); title('gaussian blurr with std = 3'); 
subplot(2,5,8), imshow(imfilter(A_uni_noise ,gaussian_kernel_5)); title('gaussian blurr with std = 5'); 
subplot(2,5,9),imshow(imfilter(A_uni_noise ,gaussian_kernel_10)); title('gaussian blurr with std = 10'); 
subplot(2,5,10), imshow(imfilter(A_uni_noise ,gaussian_kernel_20)); title('gaussian blurr with std = 20'); 


noise = randn(row_n,col_n);

A_with_noise = double(A) + noise;


conv2(A, A_with_noise);
conv2(A_with_noise, A);

%C5
F_lena_noise = fft2(A_wnoise_20);
F_filtered_img = fft2(imfilter(A_wnoise_20,gaussian_kernel_10));
F_filter = fft2(gaussian_kernel_10);
Z = immultiply(abs(F_lena_noise),abs(F_filter));
Z2 = conv2(F_lena_noise,F_filter);

colormap('gray');
figure(3),
subplot(1,5,1), imagesc(A_wnoise_20)
title ('image with nosie')
subplot(1,5,2), imagesc(log(abs(F_lena_noise)))
title ('Fourier transform image with noise')
subplot(1,5,3), imagesc(log(abs(F_filter )))
title ('Fourier transform of gaussian kernel')
subplot(1,5,4), imagesc(log(Z))
title ('convolved image with noise and gaussian filter')
subplot(1,5,4), imagesc(log(Z))
title ('inverse')





%C6
%5x5, 10x10 and20x20
box5 = fspecial('average', 5);
box10 = fspecial('average', 10);
box20 = fspecial('average', 20);

figure(4),
subplot(4,3,1), imshow(imfilter(A_wnoise_20 ,box5));  title('avg box 5x5');
subplot(4,3,2), imshow(imfilter(A_wnoise_20 ,box10)); title('avg box 10x10');
subplot(4,3,3), imshow(imfilter(A_wnoise_20 ,box20)); title('avg box 20x20');


%C7
img_median3 = medfilt2(A_uni_noise  );
img_median5 = medfilt2(A_uni_noise  , [5 5]);
img_median7 = medfilt2(A_uni_noise  , [7 7]);

img_median3_uni = medfilt2(A_uni_noise );
img_median5_uni = medfilt2(A_wnoise_20 , [5 5]);
img_median7_uni = medfilt2(A_wnoise_20 , [7 7]);


subplot(4,3,4), imshow(img_median3 ); title('median box 3x3');
subplot(4,3,5), imshow(img_median5 ); title('median box 5x5');
subplot(4,3,6), imshow(img_median7 ); title('median box 7x7');


subplot(4,3,7), imshow(imfilter(A_uni_noise ,box5));  title('avg box 5x5');
subplot(4,3,8), imshow(imfilter(A_uni_noise ,box10)); title('avg box 10x10');
subplot(4,3,9), imshow(imfilter(A_uni_noise ,box20)); title('avg box 20x20');

subplot(4,3,10), imshow(img_median3_uni ); title('median box 3x3');
subplot(4,3,11), imshow(img_median5_uni ); title('median box 5x5');
subplot(4,3,12), imshow(img_median7_uni ); title('median box 7x7');



