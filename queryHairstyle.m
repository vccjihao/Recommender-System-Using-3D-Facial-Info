clear all
close all
clc

%%
imgPath = '.\data\results\'; 
dCell = dir([imgPath]);

d = length(dCell);
s = struct2cell(dCell);
dCell = dCell(~cell2mat(s(5,:)));
d = length(dCell);

Data = zeros(length(dCell),40);
for i = 1:length(dCell)
    load(strcat(imgPath,num2str(i),'.mat'));
    Data(i,:) = b;    
end

%%
testdir = '.\data\newImages\'; 
filename = 'new1.bmp';

[ R,t,s,b ] = runDemo_local(testdir,filename);

%%
dists = zeros(length(dCell),1);
for i = 1:length(dCell)
    dists(i) = norm(b-Data(i,:)');  
end

[val, idx] = sort(dists,'ascend');
%%
k = 5;
topk = idx(1:5);

imgPath = '.\data\uniqueImages2\'; 
dCell = dir([imgPath]);

d = length(dCell);
s = struct2cell(dCell);
dCell = dCell(~cell2mat(s(5,:)));
d = length(dCell);

%%
load 01_MorphableModel.mat
ndims = 40;
FV.faces = tl;

npixels = 256;
subplot(3,5,1)
%title('Input Image')
temp = imread(strcat(testdir,filename));
temp2 = imresize(temp,[npixels,npixels]);
imshow(temp2)

subplot(3,5,2)
%title('3D Facial Shape of Input Image')
FV.vertices=reshape(shapePC(:,1:ndims)*b+shapeMU,3,size(shapePC,1)/3)';
patch(FV, 'FaceColor', [1 1 1], 'EdgeColor', 'none', 'FaceLighting', 'phong'); light; axis equal; axis off;

for i = 1:k
    subplot(3,5,5+i)
    %title(['Recommended Hairstyle Image ',num2str(i)])
    temp = imread(strcat(imgPath,num2str(idx(i)),'.jpg'));
    temp2 = imresize(temp,[npixels,npixels]);
    imshow(temp2)
end
for i = 1:k
    subplot(3,5,10+i)
    %title(['3D Facial Shape of Recommended Hairstyle Image ',num2str(i)])
    FV.vertices=reshape(shapePC(:,1:ndims)*Data(idx(i),:)'+shapeMU,3,size(shapePC,1)/3)';
    patch(FV, 'FaceColor', [1 1 1], 'EdgeColor', 'none', 'FaceLighting', 'phong'); light; axis equal; axis off;
end

%%
figure
Y = tsne(Data);
plot(Y(:,1),Y(:,2),'.')
hold on
for i = 1:k
    plot(Y(idx(i),1),Y(idx(i),2),'ro')
    hold on
end