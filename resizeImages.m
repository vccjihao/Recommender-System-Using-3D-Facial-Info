clear all
close all
clc

imgPath = '.\data\uniqueImages2\'; 
dCell = dir([imgPath]);

d = length(dCell);
s = struct2cell(dCell);
dCell = dCell(~cell2mat(s(5,:)));
d = length(dCell);

imgPath2 = '.\data\resizeImages\';
for i = 1:d
    temp = imread(strcat(imgPath,dCell(i).name));
    temp2 = imresize(temp,[64,64]);
    disp(dCell(i).name)
    imwrite(temp2, strcat(imgPath2,dCell(i).name));
end