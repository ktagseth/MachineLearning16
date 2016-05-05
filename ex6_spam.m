%This File is a modified version of ex6_spam.m 
% from the stanford online Machine Learning course
% instructed by Andrew Ng
% This has been modified to work with movie review classification 
% specifically for a kaggle competition which can be found at
% https://inclass.kaggle.com/c/sentiment-classification-on-large-movie-review
%

%% Initialization
clear ; close all; clc

% Extract Features
file_contents = readFile('9407_8.txt');
word_indices  = processEmail(file_contents);%, word_indices);
features      = emailFeatures(word_indices);

% Print Stats
fprintf('Length of feature vector: %d\n', length(features));
fprintf('Number of non-zero entries: %d\n', sum(features > 0));

fprintf('Program paused. Press enter to continue.\n');
pause;


%This loads the environment created by 
%MyProcessFunc.m

load('resultsFeaturesTestFinal.mat');

fprintf('\nTraining Linear SVM (Spam Classification)\n')
fprintf('(this may take 1 to 2 minutes) ...\n')

C = 5;
model = svmTrain(P, L, C, @linearKernel);

p = svmPredict(model, P);

fprintf('Training Accuracy: %f\n', mean(double(p == L)) * 100);

%I made a mistake and loading this environment 
%was a remedy which worked
load('resultsFeaturesTest.mat');

fprintf('\nEvaluating the trained Linear SVM on a test set ...\n')

p = svmPredict(model, Ptest);

fprintf('Test Accuracy: %f\n', mean(double(p == Ltest)) * 100);
pause;


% Sort the weights and obtin the vocabulary list
% Prints out the most significant positive words
[weight, idx] = sort(model.w, 'descend');
vocabList = getVocabList();

fprintf('\nTop predictors of positivity: \n');
for i = 1:15
    fprintf(' %-15s (%f) \n', vocabList{idx(i)}, weight(i));
end

fprintf('\n\n');
fprintf('\nProgram paused. Press enter to continue.\n');
pause;

%This loop goes through the set of 11000 unlabeled movie reviews
%
filename = '9407_8.txt';
fileID = fopen('submission.csv', 'wt+') ;
for i = 0 : 10999;
% Read and predict
    fileName1 = int2str(i) ;
    fileName = strcat(fileName1, '.txt') ;
    file_contents = readFile(fileName);
    word_indices  = processEmail(file_contents);%, word_indices);
    x             = emailFeatures(word_indices);
    p = svmPredict(model, x);
    fprintf(fileID, '%d, %d \n', i, p);
    fprintf('%d %d\n', i, p) ;
end
fclose(fileID) ;