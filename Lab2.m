Fs100 = 100;
ts100 = 0:1/Fs100:1;
Fs150 = 150;
ts150 = 0:1/Fs150:1;

%B1
t = (-1:0.01:1)';
sin_f100 = sin(2*pi*10*ts100);
fft_sin100 = fft(sin_f100);
stem(ts100,abs(fft_sin100));

sin_f150 = sin(2*pi*10*ts150);
fft_sin150 = fft(sin_f150);
stem(ts150,abs(fft_sin150));

%fft_sin = fft(y);
%ifft_sin = ifft(fft_sin);

%plot(x,fft(y))

%B2
%fft of sin wave is 1 at 0 and 2pi ? => the amplitude is collected at those
%point of the phase ???
%B3 a: different f in cos

y_f100 = cos(2*pi*10*ts100);


y_f150 = cos(2*pi*10*ts150);

%B3 b
unitstep = t>=0;

%B3 
impulse = t==0;

ramp = t.*unitstep;
quad = t.^2.*unitstep;
cos100 = cos(2*pi*1*t)/2+0.5;
cos200 = cos(2*pi*2*t)/2+0.5;

impulseFFT = fft(impulse);
unitstepFFT = fft(unitstep);

subplot(3,1,1)
plot(t,[impulse unitstep cos100 cos200])
subplot(3,1,2)
plot(t,[abs(impulseFFT) abs(unitstepFFT) abs(fft(cos100)) abs(fft(cos200))])
subplot(3,1,3)
plot(t,[angle(impulseFFT) angle(unitstepFFT) angle(fft(cos100)) angle(fft(cos200))])
%plot(t,[unitstepFFT, impulseFFT ]);




%B4
%surf(bsxfun(@(x,y)sin(x)+sin(y),-pi:0.1:pi,(-pi:0.1:pi)'));
%surf(sin(repmat(-pi:0.1:pi,100,1)));
%surf(bsxfun(@(x,y)sin(x)+y,-pi:0.1:pi,(-pi:0.1:pi)'));
[X, Y]= meshgrid(linspace(0,2*pi));
Z = sin(X).*sin(Y);
mesh(X,Y,Z);
mesh(X,Y,abs(fft2(Z)));
mesh(X,Y,angle(fft2(Z)));
Z2 = sin(X*2).*sin(Y*2);


subplot(3,1,1)
mesh(X,Y,Z2);
subplot(3,1,2)
mesh(X,Y,abs(fft2(Z2)));
subplot(3,1,3)
mesh(X,Y,angle(fft2(Z2)));

%B5
%Gaussian filter fspecial('gaussian',hsize,sigma)
[X_filter, Y_filter]= meshgrid(linspace(1,3,1));
gaussian_filter = fspecial('gaussian',5,1);
alpha1=1;
beta1=50;
alpha2=1;
beta2=50;
[rows,cols]=size(Z); 
%rearrange image
for x = 1:cols %address all columns
  for y = 1:rows %address all rows
    %fprintf(string(x>=alpha1 && x<=beta1));
    %fprintf('\n')
    if ~((x>=alpha1 && x<=beta1) && (y>=alpha2 && y<=beta2))
        %fprintf('%i\n', x);
        %fprintf('%i\n', y);
        Z(x,y)=0;
        %fprintf('%i\n',image(x,y))
    end
  end
end

%Z = imfilter(Z,gaussian_filter); 
subplot(3,1,1)
mesh(X,Y,Z);
subplot(3,1,2)
mesh(X,Y,abs(fft2(Z)));
subplot(3,1,3)
mesh(X,Y,angle(fft2(Z)));





%B6
lena_img = imread('lenaG.bmp');
colormap(gray) 
pic=imread('lenaG.bmp');
%images are stored as integers, so we need to double them for Matlab
%we also need to ensure we have a greyscale, not three colour planes 
pic=double(pic(:,:,1));
 
Fpic=fft2(rearrange(pic));
Fpic_true = fft2(pic);

%B7
%fourier transform with no phase

no_phase = abs(Fpic_true);


%B8
%fourier transform with constant magnitude
% . is nescessary for matrix ops

cols = 512;
rows = 512;
no_mag = ones(cols, rows);
for x = 1:cols %address all columns
  for y = 1:rows %address all rows
    no_mag(x,y) = Fpic_true(x,y) / norm(Fpic_true(x,y));
  end
end

imshow((ifft2(no_phase)),[]);
imshow((ifft2(no_mag)),[]);


%B10:
lenaT = transpose(lena_img);
FpicT=fft2(rearrange(lenaT));
FpicT_true = fft2(lenaT);

subplot(2,3,1), imagesc(lena_img)
title ('Original image')
subplot(2,3,2), imagesc(log(abs(Fpic_true)))
title ('Fourier transform')
subplot(2,3,3), imagesc(log(abs(Fpic)))
title ('Rearranged Fourier transform')
subplot(2,3,4), imagesc(lenaT)
title ('Rotated image')
subplot(2,3,5), imagesc(log(abs(FpicT_true)))
title ('Rotated Fourier transform')
subplot(2,3,6), imagesc(log(abs(FpicT)))
title ('Rotated Rearranged Fourier transform')




% need to check what is abs or phase
%images are stored as integers, so we need to double them for Matlab
%we also need to ensure we have a greyscale, not three colour planes 
function rearranged = rearrange(image)
%New image is rearranged so when transformed dc is at centre
%
%  Usage: new image = rearrange(image)
%
%  Parameters: image      - array of points 

%get dimensions
[rows,cols]=size(image); 

%rearrange image
for x = 1:cols %address all columns
  for y = 1:rows %address all rows
    rearranged(y,x)=image(y,x)*((-1)^(y+x)); %Eq. 2.30
  end
end
end

function boxfilter(image, alpha1, beta1, alpha2, beta2)
%New image is rearranged so when transformed dc is at centre
%
%  Usage: new image = rearrange(image)
%
%  Parameters: image      - array of points 

%get dimensions
[rows,cols]=size(image); 
%rearrange image
for x = 1:cols %address all columns
  for y = 1:rows %address all rows
    %fprintf(string(x>=alpha1 && x<=beta1));
    %fprintf('\n')
    if ((x>=alpha1 && x<=beta1) && (y>=alpha2 && y<=beta2))
        %fprintf('%i\n', x);
        %fprintf('%i\n', y);
        image(x,y) = 0;
        %fprintf('%i\n',image(x,y))
    end
  end
end
end




