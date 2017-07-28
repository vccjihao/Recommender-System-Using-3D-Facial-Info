clear all
close all
clc

imgPath = '.\data\uniqueImages\'; 
dCell = dir([imgPath]);

d = length(dCell);
s = struct2cell(dCell);
dCell = dCell(~cell2mat(s(5,:)));
d = length(dCell);

imgPath2 = '.\data\uniqueImages2\';
for i = 1:length(dCell)
    copyfile(strcat(imgPath,dCell(i).name),strcat(imgPath2,num2str(i),'.jpg'))
end
