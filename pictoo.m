function pictoo()

% kernel(H): array of weights

close all;
format compact;

climberImg = imread('climber.tiff');
figure(1),
imshow(climberImg);
datacursormode on
imgD = im2double(climberImg);
imR = imgD(:,:,1);
imG = imgD(:,:,2);
imB = imgD(:,:,3);



% part 1 no conv, just manually compute magnitude
% show magnitude of gradient of image 
% using convolution
% to implement finite differences
% scale brightness reasonably
H = double(ones(3,3)*(1/9)); %kernel(H)
%H2 = ones(3)/9; %same thing
%{
cr = conv2(imR,H);
cg = conv2(imG,H);
cb = conv2(imB,H);
cImg = cat(3, cr,cg,cb);
figure(2), imshow(cImg);
%}

grayImg = rgb2gray(climberImg);
grayImg = im2double(grayImg);
%{
figure(3), imshow(grayImg);
H2 = fspecial('gaussian', [3 3], 2);
H2
convGauss = conv2(H2, grayImg);
figure(4), imshow(convGauss);
%}

[mag, dir] = imgradient(grayImg); %for mere comparison
figure(2), imshow(mag);

%{
F = gradient(grayImg);
F2 = F+0.4;
figure(6), imshow(F);
figure(7), imshow(F2);
%}

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
sigma = 0.01;
GL = fspecial('Gaussian', [5 5], sigma);
gIx = conv2(Ix2, GL, 'same');
gIxIy = conv2(IxIy, GL, 'same');
gIy = conv2(Iy2, GL, 'same');
xx = gIxIy+gIy+gIx+Ix+Iy+Iy2+Ix2-0.04;
figure(3), imshow(xx); %final

% part 2
% find threshold for gradient magnitude 
% to determine real edges

whos('grayImg')
cEd = edge(grayImg, 'canny'); % for mere comparison
figure(4), imshow(cEd);
mean(mean(mag))
%white: 255 255 255
%black: 0 0 0
edgeImg = climberImg;
for i = 1:236
    for j = 1:364
        if(mag(j,i) > 0.429)    %Threshold 0.429?      
            edgeImg(j, i, 1) = 255;
            edgeImg(j, i, 2) = 255;
            edgeImg(j, i, 3) = 255;
        else
            edgeImg(j, i, 1) = 0;
            edgeImg(j, i, 2) = 0;
            edgeImg(j, i, 3) = 0;
        end
    end
end

figure(5), imshow(edgeImg);

% part 3 
% convolution smoothing

figure(6), surf(H);
H2 = fspecial('gaussian', [3 3], 2);
figure(7), surf(H2);

grayImg = rgb2gray(climberImg);
grayImg = im2double(grayImg);
H3 = fspecial('gaussian', [5 5], 2);
figure(8), surf(H3);
whos('H')
H
tic
convGauss1 = conv2(H,grayImg);
figure(9), imshow(convGauss1);
toc
whos('H2')
H2
tic
convGauss2 = conv2(H2, grayImg);
figure(10), imshow(convGauss2);
toc
whos('H3')
H3
tic
convGauss3 = conv2(H3, grayImg);
figure(11), imshow(convGauss3);
toc

% part 4 %% TO FIX PART 2 || FIX F2_4 to mag2

%                            from part 1
%{
F_4 = gradient(convGauss);
F2_4 = F+0.2;
figure(13), imshow(F_4);
figure(14), imshow(F2_4);
%}

[mag2, dir2] = imgradient(convGauss3);
figure(12), imshow(mag2);

imgG211 = convGauss3;
imgDdd = imgG211;


G = fspecial('Gaussian', [5 5],1);
dG = diff(G)*20;
Ix = conv2(imgDdd, dG, 'same');
Iy = conv2(imgDdd, dG', 'same');
Ix2 = Ix.^2;
IxIy = Ix.*Iy;
Iy2 = Iy.^2;
xxx = Ix+Iy;
%figure(2), imshow(xxx);
sigma = 0.01;
GL = fspecial('Gaussian', [5 5], sigma);
gIx = conv2(Ix2, GL, 'same');
gIxIy = conv2(IxIy, GL, 'same');
gIy = conv2(Iy2, GL, 'same');
xx = gIxIy+gIy+gIx+Ix+Iy+Iy2+Ix2-0.04;
figure(13), imshow(xx);

%                            from part 2
cEd_4 = edge(convGauss3, 'canny');
figure(14), imshow(cEd_4);
mean(mean(mag2))
%white: 255 255 255
%black: 0 0 0
edgeImg_4 = climberImg;
for i = 1:236
    for j = 1:364
        if(mag2(j,i) > 0.189)    %Threshold 0.429?      
            edgeImg_4(j, i, 1) = 255;
            edgeImg_4(j, i, 2) = 255;
            edgeImg_4(j, i, 3) = 255;
        else
            edgeImg_4(j, i, 1) = 0;
            edgeImg_4(j, i, 2) = 0;
            edgeImg_4(j, i, 3) = 0;
        end
    end
end

figure(15), imshow(edgeImg_4);



%part 5
grayImg_15 = imread('climber.tiff');
grayImg_5 = rgb2gray(grayImg_15);
grayImg_5 = im2double(grayImg_5);
H2_5 = fspecial('gaussian', [5 5], 4);
convGauss_5 = conv2(H2_5, mag2);
figure(16), imshow(convGauss_5);
newImg_5 = convGauss_5;
finalImg_5 = convGauss_5;
vertMask = [1, 0, -1;1, 0, -1;1, 0, -1];
%flip
vertMask = flipud(vertMask);
vertMask = fliplr(vertMask);
for i = 2:size(finalImg_5,1)-1
    for j = 2:size(finalImg_5,2)-1
        neighMat = vertMask.*newImg_5(i-1:i+1, j-1:j+1);
        av = sum(neighMat(:));
        finalImg_5(i,j) = av;
    end
end
F55 = finalImg_5+0.2;
figure(17), imshow(finalImg_5);
figure(18), imshow(F55);

newImg_5_2 = convGauss_5;
finalImg_5_2 = convGauss_5;
horMask = [1, 1, 1;0, 0, 0;-1, -1, -1];
horMask = flipud(horMask);
horMask = fliplr(horMask);
for i = 2:size(convGauss_5, 1)-1
    for j = 2:size(convGauss_5, 2)-1
        neighMat2 = horMask.*newImg_5_2(i-1:i+1,j-1:j+1);
        av2 = sum(neighMat2(:));
        finalImg_5_2(i, j) = av2;
    end
end
F522 = finalImg_5_2+0.2;
figure(19), imshow(finalImg_5_2);
figure(20), imshow(F522);

whos('finalImg_5')
whos('finalImg_5_2')
composite = finalImg_5+finalImg_5_2+0.02;
figure(21), imshow(composite);


% part 6
% (part 3) INCOMPLETE STILL: mostly done in part 1
% convolution smoothing
H6 = fspecial('gaussian', [5 5], 2);
whos('H6')
figure(22), surf(H);

grayImg_6 = rgb2gray(climberImg);
grayImg_6 = im2double(grayImg_6);

grayImg_7 = rgb2gray(edgeImg);
grayImg_7 = im2double(grayImg_7);

convGauss_6 = conv2(H6, grayImg_7);
convGauss_66 = convGauss_6+0.4;
%figure(24), imshow(convGauss_66);

convGauss_7 = conv2(H6, grayImg_6);
%figure(25), imshow(convGauss_7);

convGauss_8 = conv2(convGauss_7, grayImg_7);
%figure(26), imshow(convGauss_8);
mydoor = imread("mydoorAlbum.png");
gim = rgb2gray(mydoor);
gim = im2double(gim);
convGauss_9 = conv2(H6, gim);
%figure(27), imshow(convGauss_9);
H6
tic
u = [1/9 1/9 1/9]';
v = [1/9 1/9 1/9];

imR = mydoor(:,:,1);
imG = mydoor(:,:,2);
imB = mydoor(:,:,3);
ch = conv2(H6(:),v,gim,'same');
%figure(28), imshow(ch);
cv = conv2(u,H6(:),gim,'same');
%figure(29), imshow(cv);
whos('ch')
whos('cv')
chcvf = ch+cv;
chcvf = chcvf + 0.06;
figure(23), imshow(chcvf);
toc
cc = conv2(H6(:),v,imR,'same');
pp = conv2(H6(:),v,imG,'same');
vv = conv2(H6(:),v,imB,'same');
last = pp + vv + cc;
oi = cat(3, pp, vv, cc);
figure(24), imshow(oi);

end