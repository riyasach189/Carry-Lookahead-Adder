close all;
clear;
clc;

%%

function activityFactor = computeActivityFactor(probability)
    % computeActivityFactor Computes the activity factor given a probability
    % Input:
    %   probability - The probability value (scalar, 0 <= probability <= 1)
    % Output:
    %   activityFactor - The computed activity factor, p * (1 - p)

    % Validate the input
    if probability < 0 || probability > 1
        error('Probability must be in the range [0, 1].');
    end

    % Calculate the activity factor
    activityFactor = probability * (1 - probability);
end

function p_ci = compute_pci(p_gi, p_pi, p_ci_prev)
    % compute_pci Computes the probability of carry out (c(i+1))
    % Inputs:
    %   p_gi - Probability of generate (g(i))
    %   p_pi - Probability of propagate (p(i))
    %   p_ci_prev - Probability of carry in (c(i))
    % Output:
    %   p_ci - Probability of carry out (c(i+1))

    p_pic_prev = p_pi * p_ci_prev;
    p_ci = 1 - ((1 - p_gi) * (1 - p_pic_prev));
end

function p_si = compute_psi(p_pi, p_ci)
    % compute_psi Computes the probability of sum (s(i))
    % Inputs:
    %   p_pi - Probability of propagate (p(i))
    %   p_ci - Probability of carry in (c(i))
    % Output:
    %   p_si - Probability of sum (s(i))

    p_si = (p_pi * (1 - p_ci)) + ((1 - p_pi) * p_ci);
end

%%

% Main script
p_a0 = 1/2; p_a1 = 1/2; p_a2 = 1/2; p_a3 = 1/2;
p_b0 = 1/2; p_b1 = 1/2; p_b2 = 1/2; p_b3 = 1/2;

% pi = ai xor bi
% gi = ai and bi
p_p0 = 1/2; p_p1 = 1/2; p_p2 = 1/2; p_p3 = 1/2;
p_g0 = 1/4; p_g1 = 1/4; p_g2 = 1/4; p_g3 = 1/4;

% Initial carry-in probability
p_c0 = 1/2;

% Compute carry probabilities
p_c1 = compute_pci(p_g0, p_p0, p_c0);
p_c2 = compute_pci(p_g1, p_p1, p_c1);
p_c3 = compute_pci(p_g2, p_p2, p_c2);
p_c4 = compute_pci(p_g3, p_p3, p_c3);

% Compute sum probabilities
p_s0 = compute_psi(p_p0, p_c0);
p_s1 = compute_psi(p_p1, p_c1);
p_s2 = compute_psi(p_p2, p_c2);
p_s3 = compute_psi(p_p3, p_c3);

% Compute activity factors
af_s0 = computeActivityFactor(p_s0);
af_s1 = computeActivityFactor(p_s1);
af_s2 = computeActivityFactor(p_s2);
af_s3 = computeActivityFactor(p_s3);
af_c1 = computeActivityFactor(p_c1);
af_c2 = computeActivityFactor(p_c2);
af_c3 = computeActivityFactor(p_c3);
af_c4 = computeActivityFactor(p_c4);

% Display results
disp("P(S0) = " + num2str(p_s0) + ", AF(S0) = " + num2str(af_s0));
disp("P(C1) = " + num2str(p_c1) + ", AF(C1) = " + num2str(af_c1));
disp("P(S1) = " + num2str(p_s1) + ", AF(S1) = " + num2str(af_s1));
disp("P(C2) = " + num2str(p_c2) + ", AF(C2) = " + num2str(af_c2));
disp("P(S2) = " + num2str(p_s2) + ", AF(S2) = " + num2str(af_s2));
disp("P(C3) = " + num2str(p_c3) + ", AF(C3) = " + num2str(af_c3));
disp("P(S3) = " + num2str(p_s3) + ", AF(S3) = " + num2str(af_s3));
disp("P(C4) = " + num2str(p_c4) + ", AF(C4) = " + num2str(af_c4));
