%MyProcessFunc.m
%This function processes the entire set of training emails
%and puts the data into the word index matrix called P
%cross-validation set puts data into the matrix called Ptest
%L is a vector which stores the positivity of the review
%found in the corresponding row in the P matrix
%iterates through potentially all of the reviews, changing
%the values of i and k and the size of the matrices/vectors
clear ; close all; clc



P = zeros(5000, 89527) ;
L = zeros(5000, 1) ;
Ptest = zeros(1000, 89527) ;
Ltest = zeros(1000, 1) ;
for i = 1 : 2500 ;
    partOne = int2str(i) ;
    for j = 1 : 4 ;
        partTwo = int2str(j) ;
        file_name = strcat(partOne, '_', partTwo, '.txt' );
        if exist(file_name, 'file') ;
            %L((i - 100)) = 1 ;
            %word_indices = [];
            fprintf('%d 1 \n', i)
            file_contents = readFile(file_name);
            word_indices  = processEmail(file_contents);%, word_indices);
            %fprintf('length of feature vector: %d\n', length(emailFeatures(word_indices))) ;
            P((i),:)   = emailFeatures(word_indices);
            %fprintf('Word Indices: \n');
            %fprintf(' %d', word_indices);
            %fprintf('\n\n');
        end
    end
end
for k = 1 : 2500 ;
    partOne = int2str(k) ;
    for j = 7 : 10 ;
        partTwo = int2str(j) ;
        file_name = strcat(partOne, '_', partTwo, '.txt' );
        if exist(file_name, 'file') ;
            L([k + 2500]) = 1 ;
            %word_indices = [];
            fprintf('%d 2 \n', k)
            file_contents = readFile(file_name);
            fprintf('its here\n') ;
            word_indices  = processEmail(file_contents)%, word_indices);
            fprintf('no its here\n') ;
            %fprintf('length of feature vector: %d\n', length(emailFeatures(word_indices))) ;
            P((k + 2500),:)   = emailFeatures(word_indices);
            %fprintf('Word Indices: \n');
            %fprintf(' %d', word_indices);
            %fprintf('\n\n');
        end
    end
end

for i = 5001 : 5500 ;
    partOne = int2str(i) ;
    for j = 1 : 4 ;
        partTwo = int2str(j) ;
        file_name = strcat(partOne, '_', partTwo, '.txt' );
        if exist(file_name, 'file') ;
            %L((i - 100)) = 1 ;
            %word_indices = [];
            fprintf('%d 1 \n', i)
            file_contents = readFile(file_name);
            word_indices  = processEmail(file_contents);%, word_indices);
            %fprintf('length of feature vector: %d\n', length(emailFeatures(word_indices))) ;
            Ptest((i - 5000),:)   = emailFeatures(word_indices);
            %fprintf('Word Indices: \n');
            %fprintf(' %d', word_indices);
            %fprintf('\n\n');
        end
    end
end
for k = 5001 : 5500 ;
    partOne = int2str(k) ;
    for j = 7 : 10 ;
        partTwo = int2str(j) ;
        file_name = strcat(partOne, '_', partTwo, '.txt' );
        if exist(file_name, 'file') ;
            Ltest([k - 4500]) = 1 ;
            %word_indices = [];
            fprintf('%d 2 \n', k)
            file_contents = readFile(file_name);
            word_indices  = processEmail(file_contents)%, word_indices);
            %fprintf('length of feature vector: %d\n', length(emailFeatures(word_indices))) ;
            Ptest((k - 4500),:)   = emailFeatures(word_indices);
            %fprintf('Word Indices: \n');
            %fprintf(' %d', word_indices);
            %fprintf('\n\n');
        end
    end
end

%save('resultsIndices.mat', word_indices);
%has to save with flag -v.3 to account for large sizes of the 
%matrices produced
%Takes a long time to run, could have been more efficient but 
%did not reserve enough time to optimize 
save('resultsFeaturesTestFinal.mat', '-v7.3') ;
% Print Stats
%fprintf('Word Indices: \n');
%fprintf(' %d', word_indices);
%fprintf('\n\n');

fprintf('Program paused. Press enter to continue.\n');
pause;

fprintf('Program paused. Press enter to continue.\n');
pause;



