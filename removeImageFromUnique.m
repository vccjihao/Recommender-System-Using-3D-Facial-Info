clear all
close all
clc

imgPath = '.\data\uniqueImages\'; 
dCell = dir([imgPath]);

d = length(dCell);
s = struct2cell(dCell);
dCell = dCell(~cell2mat(s(5,:)));
d = length(dCell);
c = struct2cell(dCell);
c = c(1,:);
%%
imgPath2 = '.\data\filteredImages\';
dCell2 = dir([imgPath2]);

d2 = length(dCell2);
s2 = struct2cell(dCell2);
dCell2 = dCell2(~cell2mat(s2(5,:)));
d2 = length(dCell2);
c2 = struct2cell(dCell2);
c2 = c2(1,:);

%%
s = ismember(c,c2);
dCell3 = dCell(s);
for i = 1:length(dCell3)
    delete(strcat(imgPath,dCell3(i).name))
end
