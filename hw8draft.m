function hw8draft()

% kernel(H): array of weights

close all;
format compact;

climberImg = imread('climber.tiff');
figure(1),
imshow(climberImg);
datacursormode on
imgG211 = rgb2gray(climberImg);
imgDdd = im2double(imgG211);


G = fspecial('Gaussian', [5 5],1);
dG = diff(G)*20;
Ix = conv2(imgDdd, dG, 'same');
Iy = conv2(imgDdd, dG', 'same');
Ix2 = Ix.^2;
IxIy = Ix.*Iy;
Iy2 = Iy.^2;
xxx = Ix+Iy;
figure(2), imshow(xxx);
sigma = 0.01;
GL = fspecial('Gaussian', [5 5], sigma);
gIx = conv2(Ix2, GL, 'same');
gIxIy = conv2(IxIy, GL, 'same');
gIy = conv2(Iy2, GL, 'same');
xx = gIxIy+gIy+gIx+Ix+Iy+Iy2+Ix2-0.04;
figure(3), imshow(xx);


end


%THIS COMMENT STUB STATES THAT 
%THIS CODE IS THE PROPERTY OF OMAR R.G. (UofA Student)




[mag, dir] = imgradient(grayImg); %for mere comparison
figure(2), imshow(mag);

