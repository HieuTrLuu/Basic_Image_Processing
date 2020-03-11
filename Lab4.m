%1
[A,map] =  imread('lenaG.bmp');
[row_n, col_n] = size(A);
B = imread('NaturalView.jpg');
total_pixel = row_n * col_n;

figure(1),
subplot(1,4,1), imhist(A,10); title('hist 10 bins');
subplot(1,4,2), imhist(A,20); title('hist 20 bins');
subplot(1,4,3), imhist(A,100); title('hist 100 bins');
subplot(1,4,4), imhist(A,256); title('hist 256 bins');

range_2_52 = find(A<=52);
range_2_181 = find(A<=181);
range_2_232 = find(A<=232);

%2
figure(2),
normalized_A = im2double(A);
subplot(1,2,1), imhist(A); title('initial');
subplot(1,2,2), imhist(normalized_A); title('rescale x-range');

%3
figure(3),
subplot(1,2,1), histogram(A,'Normalization','probability'); title('AOC = 1');
subplot(1,2,2), histogram(normalized_A,'Normalization','probability'); title('AOC = 1');

p_2_52 = find(A<=52)/total_pixel;
p_2_181 = find(A<=181)/total_pixel ;
p_2_232 = find(A<=232)/total_pixel;

%4
double_A =double(A);
mu = 0;
sigma = 20;
array_gaussian_noise=mu+randn(row_n,col_n)*sigma;
A_wnoise_20  = double_A + array_gaussian_noise;
min_A_wnoise_20 = min(A_wnoise_20(:));
max_A_wnoise_20 = max(A_wnoise_20(:));

figure(4),
bias = abs(min_A_wnoise_20) +100;
slope = 1.5;

%Linear scaling
A_Lineamin_A_wnoise_20r_scaling = l_scale(A_wnoise_20, slope, bias);


%Linear scaling with clipping
%clip range from min value to -10

A_Linear_clipping = l_scale(A_wnoise_20, slope, bias);


%Abosolute value scaling
A_abs_scaling = abs(A_wnoise_20);

% subplot(2,3,1), histogram(A,'Normalization','probability'); title('AOC = 1');
% subplot(2,3,2), histogram(normalized_A,'Normalization','probability'); title('AOC = 1');
% subplot(2,3,3), histogram(normalized_A,'Normalization','probability'); title('AOC = 1');
% subplot(2,3,4), histogram(normalized_A,'Normalization','probability'); title('AOC = 1');
% subplot(2,3,5), histogram(normalized_A,'Normalization','probability'); title('AOC = 1');
% subplot(2,3,6), histogram(normalized_A,'Normalization','probability'); title('AOC = 1');

%5
B_lscale = l_scale(double(B), slope, bias);
figure(5),
subplot(2,2,1), imshow(B); title('og = 1');
subplot(2,2,2), imshow(B_lscale,[]); title('linear scale, slope =1.5, bias = 100 ');
subplot(2,2,3), histogram(B,'Normalization','probability'); title('AOC = 1');
subplot(2,2,4), histogram(B_lscale ,'Normalization','probability'); title('AOC = 1');

%6
gamma_1=1/2;
gamma_2=1/3;
gamma_3=1/5;

c=1;
p_img_1 = ones(row_n, col_n);
p_img_2 = ones(row_n, col_n);
p_img_3 = ones(row_n, col_n);
for i=1:row_n
    for j=1:col_n
        p_img_1(i,j) = c*(double_A(i,j)^gamma_1);
        p_img_2(i,j) = c*(double_A(i,j)^gamma_2);
        p_img_3(i,j) = c*(double_A(i,j)^gamma_3);
    end    
end

figure(6),
subplot(1,4,1), imshow(A); title('og = 1');
subplot(1,4,2), imshow(p_img_1,[]); title('linear scale, slope =1.5, bias = 100 ');
subplot(1,4,3), imshow(p_img_2,[]); title('linear scale, slope =1.5, bias = 100 ');
subplot(1,4,4), imshow(p_img_3,[]); title('linear scale, slope =1.5, bias = 100 ');

%7
figure(7),
imshow(-double_A,[]); title('negative images');
% subplot(1,4,1), imshow(A); title('og = 1');
% subplot(1,4,2), imshow(p_img_1,[]); title('linear scale, slope =1.5, bias = 100 ');

%8
figure(8),
imshow(double_A/255,[]); title('inverse of image');

%9
img_eql = histeq(B);
[C,T] = histeq(B, 255);
figure(9),
subplot(2,2,1), imshow(B); title('og');
subplot(2,2,2), imhist(B); title('histogram og');
subplot(2,2,3), imshow(C); title('og = 1');
subplot(2,2,4), imhist(C); title('histogram equalisation');

%change count here so that length of it is 255, atm it is 100->233 or smt, 
counts = histcounts(B);
cdf = cumsum(counts)/sum(counts);

figure(10),
plot((0:255),cdf);
subplot(2,2,1), plot((0:255),T); title('cdf og');
subplot(2,2,2), plot((0:255),T); title('cdf euqlization');



