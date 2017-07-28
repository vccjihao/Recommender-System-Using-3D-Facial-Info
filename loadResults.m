clear all
close all
clc

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

Y = tsne(Data);
plot(Y(:,1),Y(:,2),'.')
save embeded2D.mat Y
csvwrite('embeded2D.dat',Y)