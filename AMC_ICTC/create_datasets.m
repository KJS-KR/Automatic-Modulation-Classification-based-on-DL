load patients.mat
T = table(LastName,Age,Weight,Smoker);
T(1:5,:)

filename = 'patientdata.xlsx';
writetable(T,filename,'Sheet',1,'Range','D1')