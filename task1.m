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

%example of how to use only a subset of the formants
%training_data = training_data(:,12:14,:);
%test_data = test_data(:,12:14,:);

C = zeros(n_formants,n_formants,12); %full covariance matrices declaration
C_diag = zeros(n_formants,n_formants,12);  %diagonal covariance matrices declaration
mu = zeros(n_formants,12); %mean vectors declaration

%the covariances and means for each vowel are calculated
for i = 1:12   
    C(:,:,i) = cov(training_data(:,:,i));
    C_diag(:,:,i) = C(:,:,i).*eye(n_formants);
    mu(:,i) = mean(training_data(:,:,i));    
end

%% Classification of the vocals

%creating the confusion matrix for the full cov matrix
for i = 1:12
    confm_full(i,:) = classify_vocal(test_data(:,:,i),mu,C);
end

%computing the error rate for the full cov matrix
errors_full = sum(confm_full,'all')-sum(confm_full.*eye(12),'all');
error_rate_full = errors_full/(69*12)
    
%creating the confusion matrix for the diagonal cov matrix
for i = 1:12
    confm_diag(i,:) = classify_vocal(test_data(:,:,i),mu,C_diag);
end

%computing the error rate for the diagonal cov matrix
errors_diag = sum(confm_diag,'all')-sum(confm_diag.*eye(12),'all');
error_rate_diag = errors_diag/(69*12)

%returning a row of the confusion matrix for a given vocal
function confm_row = classify_vocal(test_set,mu,C)
    confm_row = zeros(12,1);
    for i = 1:69
        class = classify_sample(test_set(i,:),mu,C);
        confm_row(class) = confm_row(class) + 1;
    end
end

%returning the predicted class for a vocal sample
function class = classify_sample(x,mu,C)
    probabilities = zeros(1,12);
    %iterating over all the vocal distributions
    for i = 1:12
        probabilities(i) = mvnpdf(x',mu(:,i),C(:,:,i));
    end
    %returning the index of the maximum probability
    [~,class] = max(probabilities);
end





