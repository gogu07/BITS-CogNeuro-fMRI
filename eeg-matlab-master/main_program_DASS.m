load filter_coef.mat

%%%%%%%%%%%%%%%%%%%%%QUESTION%%%%%%%%%%%%%%%%%%%%%%%%%

[ques_a01,ques_b01,ques_d01,ques_t01,ques_g01]=basic_filter(Q1_Segment_01,alpha,beta,delta,theta,gamma);
[ques_a02,ques_b02,ques_d02,ques_t02,ques_g02]=basic_filter(Q2_Segment_01,alpha,beta,delta,theta,gamma);
[ques_a03,ques_b03,ques_d03,ques_t03,ques_g03]=basic_filter(Q3_Segment_01,alpha,beta,delta,theta,gamma);
[ques_a04,ques_b04,ques_d04,ques_t04,ques_g04]=basic_filter(Q4_Segment_01,alpha,beta,delta,theta,gamma);
[ques_a05,ques_b05,ques_d05,ques_t05,ques_g05]=basic_filter(Q5_Segment_01,alpha,beta,delta,theta,gamma);
[ques_a06,ques_b06,ques_d06,ques_t06,ques_g06]=basic_filter(Q6_Segment_01,alpha,beta,delta,theta,gamma);
[ques_a07,ques_b07,ques_d07,ques_t07,ques_g07]=basic_filter(Q7_Segment_01,alpha,beta,delta,theta,gamma);
[ques_a08,ques_b08,ques_d08,ques_t08,ques_g08]=basic_filter(Q8_Segment_01,alpha,beta,delta,theta,gamma);
[ques_a09,ques_b09,ques_d09,ques_t09,ques_g09]=basic_filter(Q9_Segment_01,alpha,beta,delta,theta,gamma);
[ques_a10,ques_b10,ques_d10,ques_t10,ques_g10]=basic_filter(Q10_Segment_01,alpha,beta,delta,theta,gamma);
[ques_a11,ques_b11,ques_d11,ques_t11,ques_g11]=basic_filter(Q11_Segment_01,alpha,beta,delta,theta,gamma);
[ques_a12,ques_b12,ques_d12,ques_t12,ques_g12]=basic_filter(Q12_Segment_01,alpha,beta,delta,theta,gamma);
[ques_a13,ques_b13,ques_d13,ques_t13,ques_g13]=basic_filter(Q13_Segment_01,alpha,beta,delta,theta,gamma);
[ques_a14,ques_b14,ques_d14,ques_t14,ques_g14]=basic_filter(Q14_Segment_01,alpha,beta,delta,theta,gamma);
[ques_a15,ques_b15,ques_d15,ques_t15,ques_g15]=basic_filter(Q15_Segment_01,alpha,beta,delta,theta,gamma);
[ques_a16,ques_b16,ques_d16,ques_t16,ques_g16]=basic_filter(Q16_Segment_01,alpha,beta,delta,theta,gamma);
[ques_a17,ques_b17,ques_d17,ques_t17,ques_g17]=basic_filter(Q17_Segment_01,alpha,beta,delta,theta,gamma);
[ques_a18,ques_b18,ques_d18,ques_t18,ques_g18]=basic_filter(Q18_Segment_01,alpha,beta,delta,theta,gamma);
[ques_a19,ques_b19,ques_d19,ques_t19,ques_g19]=basic_filter(Q19_Segment_01,alpha,beta,delta,theta,gamma);
[ques_a20,ques_b20,ques_d20,ques_t20,ques_g20]=basic_filter(Q20_Segment_01,alpha,beta,delta,theta,gamma);
[ques_a21,ques_b21,ques_d21,ques_t21,ques_g21]=basic_filter(Q21_Segment_01,alpha,beta,delta,theta,gamma);


%%%%%%%%%%%%%%%%%%%%%%%%%%%RESPONSE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[resp_a01,resp_b01,resp_d01,resp_t01,resp_g01]=basic_filter(REP_Segment_01,alpha,beta,delta,theta,gamma);
[resp_a02,resp_b02,resp_d02,resp_t02,resp_g02]=basic_filter(REP_Segment_02,alpha,beta,delta,theta,gamma);
[resp_a03,resp_b03,resp_d03,resp_t03,resp_g03]=basic_filter(REP_Segment_03,alpha,beta,delta,theta,gamma);
[resp_a04,resp_b04,resp_d04,resp_t04,resp_g04]=basic_filter(REP_Segment_04,alpha,beta,delta,theta,gamma);
[resp_a05,resp_b05,resp_d05,resp_t05,resp_g05]=basic_filter(REP_Segment_05,alpha,beta,delta,theta,gamma);
[resp_a06,resp_b06,resp_d06,resp_t06,resp_g06]=basic_filter(REP_Segment_06,alpha,beta,delta,theta,gamma);
[resp_a07,resp_b07,resp_d07,resp_t07,resp_g07]=basic_filter(REP_Segment_07,alpha,beta,delta,theta,gamma);
[resp_a08,resp_b08,resp_d08,resp_t08,resp_g08]=basic_filter(REP_Segment_08,alpha,beta,delta,theta,gamma);
[resp_a09,resp_b09,resp_d09,resp_t09,resp_g09]=basic_filter(REP_Segment_09,alpha,beta,delta,theta,gamma);
[resp_a10,resp_b10,resp_d10,resp_t10,resp_g10]=basic_filter(REP_Segment_10,alpha,beta,delta,theta,gamma);
[resp_a11,resp_b11,resp_d11,resp_t11,resp_g11]=basic_filter(REP_Segment_11,alpha,beta,delta,theta,gamma);
[resp_a12,resp_b12,resp_d12,resp_t12,resp_g12]=basic_filter(REP_Segment_12,alpha,beta,delta,theta,gamma);
[resp_a13,resp_b13,resp_d13,resp_t13,resp_g13]=basic_filter(REP_Segment_13,alpha,beta,delta,theta,gamma);
[resp_a14,resp_b14,resp_d14,resp_t14,resp_g14]=basic_filter(REP_Segment_14,alpha,beta,delta,theta,gamma);
[resp_a15,resp_b15,resp_d15,resp_t15,resp_g15]=basic_filter(REP_Segment_15,alpha,beta,delta,theta,gamma);
[resp_a16,resp_b16,resp_d16,resp_t16,resp_g16]=basic_filter(REP_Segment_16,alpha,beta,delta,theta,gamma);
[resp_a17,resp_b17,resp_d17,resp_t17,resp_g17]=basic_filter(REP_Segment_17,alpha,beta,delta,theta,gamma);
[resp_a18,resp_b18,resp_d18,resp_t18,resp_g18]=basic_filter(REP_Segment_18,alpha,beta,delta,theta,gamma);
[resp_a19,resp_b19,resp_d19,resp_t19,resp_g19]=basic_filter(REP_Segment_19,alpha,beta,delta,theta,gamma);
[resp_a20,resp_b20,resp_d20,resp_t20,resp_g20]=basic_filter(REP_Segment_20,alpha,beta,delta,theta,gamma);
[resp_a21,resp_b21,resp_d21,resp_t21,resp_g21]=basic_filter(REP_Segment_21,alpha,beta,delta,theta,gamma);


%%Baseline correction
%%%%%%%%%%%%%%%%%%%%%%QUESTIONS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[base_ques_a01,base_ques_b01,base_ques_d01,base_ques_t01,base_ques_g01]=base_correction(ques_a01,ques_b01,ques_d01,ques_t01,ques_g01);
[base_ques_a02,base_ques_b02,base_ques_d02,base_ques_t02,base_ques_g02]=base_correction(ques_a02,ques_b02,ques_d02,ques_t02,ques_g02);
[base_ques_a03,base_ques_b03,base_ques_d03,base_ques_t03,base_ques_g03]=base_correction(ques_a03,ques_b03,ques_d03,ques_t03,ques_g03);
[base_ques_a04,base_ques_b04,base_ques_d04,base_ques_t04,base_ques_g04]=base_correction(ques_a04,ques_b04,ques_d04,ques_t04,ques_g04);
[base_ques_a05,base_ques_b05,base_ques_d05,base_ques_t05,base_ques_g05]=base_correction(ques_a05,ques_b05,ques_d05,ques_t05,ques_g05);
[base_ques_a06,base_ques_b06,base_ques_d06,base_ques_t06,base_ques_g06]=base_correction(ques_a06,ques_b06,ques_d06,ques_t06,ques_g06);
[base_ques_a07,base_ques_b07,base_ques_d07,base_ques_t07,base_ques_g07]=base_correction(ques_a07,ques_b07,ques_d07,ques_t07,ques_g07);
[base_ques_a08,base_ques_b08,base_ques_d08,base_ques_t08,base_ques_g08]=base_correction(ques_a08,ques_b08,ques_d08,ques_t08,ques_g08);
[base_ques_a09,base_ques_b09,base_ques_d09,base_ques_t09,base_ques_g09]=base_correction(ques_a09,ques_b09,ques_d09,ques_t09,ques_g09);
[base_ques_a10,base_ques_b10,base_ques_d10,base_ques_t10,base_ques_g10]=base_correction(ques_a10,ques_b10,ques_d10,ques_t10,ques_g10);
[base_ques_a11,base_ques_b11,base_ques_d11,base_ques_t11,base_ques_g11]=base_correction(ques_a11,ques_b11,ques_d11,ques_t11,ques_g11);
[base_ques_a12,base_ques_b12,base_ques_d12,base_ques_t12,base_ques_g12]=base_correction(ques_a12,ques_b12,ques_d12,ques_t12,ques_g12);
[base_ques_a13,base_ques_b13,base_ques_d13,base_ques_t13,base_ques_g13]=base_correction(ques_a13,ques_b13,ques_d13,ques_t13,ques_g13);
[base_ques_a14,base_ques_b14,base_ques_d14,base_ques_t14,base_ques_g14]=base_correction(ques_a14,ques_b14,ques_d14,ques_t14,ques_g14);
[base_ques_a15,base_ques_b15,base_ques_d15,base_ques_t15,base_ques_g15]=base_correction(ques_a15,ques_b15,ques_d15,ques_t15,ques_g15);
[base_ques_a16,base_ques_b16,base_ques_d16,base_ques_t16,base_ques_g16]=base_correction(ques_a16,ques_b16,ques_d16,ques_t16,ques_g16);
[base_ques_a17,base_ques_b17,base_ques_d17,base_ques_t17,base_ques_g17]=base_correction(ques_a17,ques_b17,ques_d17,ques_t17,ques_g17);
[base_ques_a18,base_ques_b18,base_ques_d18,base_ques_t18,base_ques_g18]=base_correction(ques_a18,ques_b18,ques_d18,ques_t18,ques_g18);
[base_ques_a19,base_ques_b19,base_ques_d19,base_ques_t19,base_ques_g19]=base_correction(ques_a19,ques_b19,ques_d19,ques_t19,ques_g19);
[base_ques_a20,base_ques_b20,base_ques_d20,base_ques_t20,base_ques_g20]=base_correction(ques_a20,ques_b20,ques_d20,ques_t20,ques_g20);
[base_ques_a21,base_ques_b21,base_ques_d21,base_ques_t21,base_ques_g21]=base_correction(ques_a21,ques_b21,ques_d21,ques_t21,ques_g21);

%%%%%%%%%%%%%%%%%%%%%%%%%RESPONSE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[base_resp_a01,base_resp_b01,base_resp_d01,base_resp_t01,base_resp_g01]=base_correction(resp_a01,resp_b01,resp_d01,resp_t01,resp_g01);
[base_resp_a02,base_resp_b02,base_resp_d02,base_resp_t02,base_resp_g02]=base_correction(resp_a02,resp_b02,resp_d02,resp_t02,resp_g02);
[base_resp_a03,base_resp_b03,base_resp_d03,base_resp_t03,base_resp_g03]=base_correction(resp_a03,resp_b03,resp_d03,resp_t03,resp_g03);
[base_resp_a04,base_resp_b04,base_resp_d04,base_resp_t04,base_resp_g04]=base_correction(resp_a04,resp_b04,resp_d04,resp_t04,resp_g04);
[base_resp_a05,base_resp_b05,base_resp_d05,base_resp_t05,base_resp_g05]=base_correction(resp_a05,resp_b05,resp_d05,resp_t05,resp_g05);
[base_resp_a06,base_resp_b06,base_resp_d06,base_resp_t06,base_resp_g06]=base_correction(resp_a06,resp_b06,resp_d06,resp_t06,resp_g06);
[base_resp_a07,base_resp_b07,base_resp_d07,base_resp_t07,base_resp_g07]=base_correction(resp_a07,resp_b07,resp_d07,resp_t07,resp_g07);
[base_resp_a08,base_resp_b08,base_resp_d08,base_resp_t08,base_resp_g08]=base_correction(resp_a08,resp_b08,resp_d08,resp_t08,resp_g08);
[base_resp_a09,base_resp_b09,base_resp_d09,base_resp_t09,base_resp_g09]=base_correction(resp_a09,resp_b09,resp_d09,resp_t09,resp_g09);
[base_resp_a10,base_resp_b10,base_resp_d10,base_resp_t10,base_resp_g10]=base_correction(resp_a10,resp_b10,resp_d10,resp_t10,resp_g10);
[base_resp_a11,base_resp_b11,base_resp_d11,base_resp_t11,base_resp_g11]=base_correction(resp_a11,resp_b11,resp_d11,resp_t11,resp_g11);
[base_resp_a12,base_resp_b12,base_resp_d12,base_resp_t12,base_resp_g12]=base_correction(resp_a12,resp_b12,resp_d12,resp_t12,resp_g12);
[base_resp_a13,base_resp_b13,base_resp_d13,base_resp_t13,base_resp_g13]=base_correction(resp_a13,resp_b13,resp_d13,resp_t13,resp_g13);
[base_resp_a14,base_resp_b14,base_resp_d14,base_resp_t14,base_resp_g14]=base_correction(resp_a14,resp_b14,resp_d14,resp_t14,resp_g14);
[base_resp_a15,base_resp_b15,base_resp_d15,base_resp_t15,base_resp_g15]=base_correction(resp_a15,resp_b15,resp_d15,resp_t15,resp_g15);
[base_resp_a16,base_resp_b16,base_resp_d16,base_resp_t16,base_resp_g16]=base_correction(resp_a16,resp_b16,resp_d16,resp_t16,resp_g16);
[base_resp_a17,base_resp_b17,base_resp_d17,base_resp_t17,base_resp_g17]=base_correction(resp_a17,resp_b17,resp_d17,resp_t17,resp_g17);
[base_resp_a18,base_resp_b18,base_resp_d18,base_resp_t18,base_resp_g18]=base_correction(resp_a18,resp_b18,resp_d18,resp_t18,resp_g18);
[base_resp_a19,base_resp_b19,base_resp_d19,base_resp_t19,base_resp_g19]=base_correction(resp_a19,resp_b19,resp_d19,resp_t19,resp_g19);
[base_resp_a20,base_resp_b20,base_resp_d20,base_resp_t20,base_resp_g20]=base_correction(resp_a20,resp_b20,resp_d20,resp_t20,resp_g20);
[base_resp_a21,base_resp_b21,base_resp_d21,base_resp_t21,base_resp_g21]=base_correction(resp_a21,resp_b21,resp_d21,resp_t21,resp_g21);

