clear all
close all
clc

imgPath = '.\data\uniqueImages\';
dCell = dir([imgPath]);

d = length(dCell);
s = struct2cell(dCell);
dCell = dCell(~cell2mat(s(5,:)));
d = length(dCell);

%%
addpath('ZhuRamananDetector','optimisations','utils','comparison');

% YOU MUST set this to the base directory of the Basel Face Model
BFMbasedir = '';

% Load morphable model
load(strcat(BFMbasedir,'01_MorphableModel.mat'));
% Important to use double precision for use in optimisers later
shapeEV = double(shapeEV);
shapePC = double(shapePC);
shapeMU = double(shapeMU);

% We need edge-vertex and edge-face lists to speed up finding occluding boundaries
% Either: 1. Load precomputed edge structure for Basel Face Model
load('BFMedgestruct.mat');
% Or: 2. Compute lists for new model:
%TR = triangulation(tl,ones(k,1),ones(k,1),ones(k,1));
%Ev = TR.edges;
%clear TR;
%Ef = meshFaceEdges( tl,Ev );
%save('edgestruct.mat','Ev','Ef');

%% ADJUSTABLE PARAMETERS

% Number of model dimensions to use
ndims = 40;
% Prior weight for initial landmark fitting
w_initialprior=0.7;
% Number of iterations for iterative closest edge fitting
icefniter=7;

options.Ef = Ef;
options.Ev = Ev;
% w1 = weight for edges
% w2 = weight for landmarks
% w3 = 1-w1-w2 = prior weight
options.w1 = 0.45;
options.w2 = 0.15;
%%
imgPath2 = '.\data\filteredImages\';
imgPath3 = '.\data\filteredImages_2struct\';

% % cd(imgPath)
nameScanned = {};
parfor i = 1:length(dCell)
    disp(dCell(i).name)
    im = imread(strcat(imgPath,dCell(i).name));
    edgeim = edge(rgb2gray(im),'canny',0.15);
    nameScanned{i} = dCell(i).name;
    
    bs = LandmarkDetector(im);
    if isstruct(bs)
        if size(bs,2) == 1
            if size(bs.xy,1)==68
                copyfile(strcat(imgPath,dCell(i).name),imgPath2)
    %             copyfile(strcat(imgPath,dCell(i).name),strcat('.\filteredImages\',num2str(idx),'.jpg'))
%                   disp(dCell(i).name)
            end
        else
            if size(bs(2).xy,1)==68
                copyfile(strcat(imgPath,dCell(i).name),imgPath3)
    %             copyfile(strcat(imgPath,dCell(i).name),strcat('.\filteredImages\',num2str(idx),'.jpg'))
%                   disp(dCell(i).name)
            end
        end
    end
    delete(strcat(imgPath,dCell(i).name))
end
