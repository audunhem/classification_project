%% Initalization of variables, data and distributions

training_data = [];
test_data = [];
n_formants = 14; %variable to enable use of a subset of formants

%get the testing and training data for all vowels
for i = 1:12
    [train, test] = vowel_data(i);
    training_data(:,:,i) = train;
    test_data(:,:,i) = test;
end

%example of how to use only a subset of the formants (here n_formants = 13)
%training_data = training_data(:,[1:5 7:14],:);
%test_data = test_data(:,[1:5 7:14],:);

GMMs = cell(1,12,10); %declaring an empty call array to hold the GMMs 
M = 2; %the number of Gaussians in each GMM


%filling the cell array with a GMM for each vocal
for i = 1:12
    GMMs{i} = fitgmdist(training_data(:,:,i),M,'Regularize', 1e-5,'CovarianceType','diagonal');
end

%% Classification of the vocals

%creating the confusion matrix
for i = 1:12
    confm(i,:) = classify_vocal(test_data(:,:,i),GMMs);
end

%computing the error rate
errors = sum(confm,'all')-sum(confm.*eye(12),'all');
error_rate = errors/(69*12)

%returning a row of the confusion matrix for a given vocal
function confm_row = classify_vocal(test_set,GMM)
    confm_row = zeros(12,1);
    for i = 1:69
        class = classify_sample(test_set(i,:),GMM);
        confm_row(class) = confm_row(class) + 1;
    end
end

%returning the predicted class for a vocal sample
function class = classify_sample(x,GMM)
    probabilities = zeros(1,12);
    for i = 1:12
        %iterating over all the vocal distributions
        probabilities(i) = 0;
        for j = 1:GMM{i}.NumComponents
            probabilities(i) = probabilities(i) + GMM{i}.ComponentProportion(j)*mvnpdf(x,GMM{i}.mu(j,:),GMM{i}.Sigma(:,:,j));
        end
    end
    %returning the index of the maximum probability
    [~,class] = max(probabilities);
end








