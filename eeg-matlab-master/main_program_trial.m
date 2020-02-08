load filter_coef.mat

%[ques_a01,ques_b01,ques_d01,ques_t01,ques_g01]=basic_filter(QUESTION_Segment_01,alpha,beta,delta,theta,gamma);
%[wq_a01,wq_b01,wq_d01,wq_t01,wq_g01]=windowed_mean(ques_a01,ques_b01,ques_d01,ques_t01,ques_g01);

[ques_a01,ques_b01,ques_d01,ques_t01,ques_g01]=basic_filter(Q1_Segment_01,alpha,beta,delta,theta,gamma);
[wq_a01,wq_b01,wq_d01,wq_t01,wq_g01]=windowed_mean(ques_a01,ques_b01,ques_d01,ques_t01,ques_g01);

