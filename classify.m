

training_data = [];
test_data = [];

for i = 1:12
    [train, test] = t(i);
    training_data(:,:,i) = train;
    test_data(:,:,i) = test;
end

C = zeros(14,14,12);
C_diag = zeros(14,14,12);
mu = zeros(14,12);


for i = 1:12   
    C(:,:,i) = cov(training_data(:,:,i));
    C_diag(:,:,i) = C(:,:,i).*eye(14);
    mu(:,i) = mean(training_data(:,:,i));
      
end

errors_full = 0;
for i = 1:12
    confm_full(i,:) = classify_vocal(test_data(:,:,i),mu,C);
    errors_full = errors_full + sum(confm_full(i,:))-confm_full(i,i);
end

error_rate_full = errors_full/(69*12);
    
errors_diag = 0;
for i = 1:12
    confm_diag(i,:) = classify_vocal(test_data(:,:,i),mu,C_diag);
    errors_diag = errors_diag + sum(confm_diag(i,:))-confm_diag(i,i);
end
error_rate_diag = errors_diag/(69*12);

function confm_row = classify_vocal(test_set,mu,C)
    confm_row = zeros(12,1);
    for i = 1:69
        class = classify_sample(test_set(i,:),mu,C);
        confm_row(class) = confm_row(class) + 1;
    end
end

function class = classify_sample(x,mu,C)
    probabilities = zeros(1,12);
    for i = 1:12
        probabilities(i) = mvnpdf(x',mu(:,i),C(:,:,i));
    end
    [~,class] = max(probabilities);
end





