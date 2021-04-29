function hw8()

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



% part 1 %fix!!!! no conv, just manually compute magnitude INCOMPLETE STILL
% show magnitude of gradient of image 
% using convolution
% to implement finite differences
% scale brightness reasonably
H = double(ones(3,3)*(1/9)); %kernel(H)
%H2 = ones(3)/9; %same thing
cr = conv2(imR,H);
cg = conv2(imG,H);
cb = conv2(imB,H);
cImg = cat(3, cr,cg,cb);
figure(2), imshow(cImg);

grayImg = rgb2gray(climberImg);
grayImg = im2double(grayImg);
figure(3), imshow(grayImg);
H2 = fspecial('gaussian', [3 3], 2);
H2
convGauss = conv2(H2, grayImg);
figure(4), imshow(convGauss);

[mag, dir] = imgradient(grayImg);
figure(5), imshowpair(mag,dir,'montage');


F = gradient(grayImg);
F2 = F+0.4;
figure(6), imshow(F);
figure(7), imshow(F2);
%max(max(F2))
%min(min(F2))
%mean(mean(F2))


% part 2
% find threshold for gradient magnitude 
% to determine real edges

whos('grayImg')
whos('F2')
cEd = edge(grayImg, 'canny');
figure(8), imshow(cEd);

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

figure(9), imshow(edgeImg);



% part 3 INCOMPLETE STILL: mostly done in part 1
% convolution smoothing
whos('H2')
figure(10), surf(H2);

grayImg = rgb2gray(climberImg);
grayImg = im2double(grayImg);
figure(11), imshow(grayImg);
H3 = fspecial('gaussian', [5 5], 2);
convGauss = conv2(H3, grayImg);
figure(12), imshow(convGauss);



%THIS COMMENT STUB STATES THAT 
%THIS CODE IS THE PROPERTY OF OMAR R.G. (UofA Student)

% part 4 %% TO FIX PART 2 || FIX F2_4 to mag2

%                           from part 1
F_4 = gradient(convGauss);
F2_4 = F+0.2;
figure(13), imshow(F_4);
figure(14), imshow(F2_4);
%                            from part 2
cEd_4 = edge(grayImg, 'canny');
figure(15), imshow(cEd_4);

%white: 255 255 255
%black: 0 0 0
edgeImg_4 = climberImg;
for i = 1:236
    for j = 1:364
        if(F2_4(j,i) > 0.229)    %Threshold 0.429?      
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

figure(16), imshow(edgeImg_4);

%part 5
grayImg_15 = imread('climber.tiff');
grayImg_5 = rgb2gray(grayImg_15);
grayImg_5 = im2double(grayImg_5);
H2_5 = fspecial('gaussian', [5 5], 4);
convGauss_5 = conv2(H2_5, grayImg_5);
figure(17), imshow(convGauss_5);

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
figure(18), imshow(finalImg_5);
figure(19), imshow(F55);

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
figure(20), imshow(finalImg_5_2);
figure(21), imshow(F522);

whos('finalImg_5')
whos('finalImg_5_2')
composite = F55+F522;
figure(22), imshow(composite);

% part 6
% (part 3) INCOMPLETE STILL: mostly done in part 1
% convolution smoothing
H6 = fspecial('gaussian', [5 5], 2);
whos('H6')
figure(23), surf(H6);

grayImg_6 = rgb2gray(climberImg);
grayImg_6 = im2double(grayImg_6);

grayImg_7 = rgb2gray(edgeImg);
grayImg_7 = im2double(grayImg_7);

convGauss_6 = conv2(H6, grayImg_7);
convGauss_66 = convGauss_6+0.4;
figure(24), imshow(convGauss_66);

convGauss_7 = conv2(H6, grayImg_6);
figure(25), imshow(convGauss_7);

convGauss_8 = conv2(convGauss_7, grayImg_7);
figure(26), imshow(convGauss_8);

gim = rgb2gray(climberImg);
gim = im2double(gim);
convGauss_9 = conv2(H6, gim);
figure(27), imshow(convGauss_9);
H6
u = [1/9 1/9 1/9]';
v = [1/9 1/9 1/9];
ch = conv2(H(:),v,gim,'same');
figure(28), imshow(ch);
cv = conv2(u,H(:),gim,'same');
figure(29), imshow(cv);
whos('ch')
whos('cv')
chcvf = ch+cv;
chcvf = chcvf + 0.06;
figure(30), imshow(chcvf);

end