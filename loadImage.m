clear all
close all
clc

imgPath = '.\data\filteredImages\'; 
dCell = dir([imgPath]);

d = length(dCell);
s = struct2cell(dCell);
dCell = dCell(~cell2mat(s(5,:)));
d = length(dCell);

idx = zeros(d,1);
i = 1;
while(1)
    if i <= d - 3
        if (dCell(i).bytes ~= dCell(i+1).bytes) && (dCell(i).bytes ~= dCell(i+2).bytes) && (dCell(i).bytes ~= dCell(i+3).bytes)
            idx(i) = i;
        end
    else
        idx(i) = i;
    end
    
    i = i + 1;
    if i >d 
        break;
    end
end
idx = find(idx);

for i = 1:length(idx)
    copyfile(strcat(imgPath,dCell(idx(i)).name),strcat('.\data\uniqueImages\'))
end
