clear all
clc

fprintf(['Hello! This program will help you determine the fastest way to ' ...
    'reach your financial goals. \n'])
fprintf(['Note: This program assumes you have a stock portfolio, 401k, ROTH IRA, and bank' ...
    ' account. \n'])
fprintf('\n')
fprintf(['The information used to calculate your tax is based on federal' ...
    ' and state income tax from the year 2022. \n'])
fprintf(['Note: This calculator assumes you are single when calculating your' ...
    ' taxes and should be updated accordingly. \n'])
fprintf('\n')
fprintf(['Throughout the program you can choose how often you would like to' ...
    ' update your salary. \n'])
fprintf(['Note: Calculating your projected expenses and pre-taxed salary ' ...
    'before hand will make this tool far more accurate. \n'])
fprintf('\n')
fprintf(['I will be releasing new versions of this program periodically so keep' ...
    ' an eye out for that. \n'])
fprintf('\n')
fprintf('Always remember to pay yourself first! Mental health and happiness should be prioritized!')
fprintf('\n')
fprintf('\n')

% Input your current savings, your salary before tax, and how much you
% spend annually, and you goal
warning('off')
current_normal_savings = input('How much do you have in your Stock Portfolio? \n');
while class(current_normal_savings) ~= class(1.1)
    fprintf('Please input a number. \n')
    current_normal_savings = input('How much do you have in your Stock Portfolio? \n');
end

current_roth_savings = input('How much do you have in your ROTH IRA? \n');
while class(current_roth_savings) ~= class(1.1)
    fprintf('Please input a number. \n')
    current_roth_savings = input('How much do you have in your ROTH IRA? \n');
end

current_f01k_savings = input('How much do you have in your 401k? \n');
while class(current_f01k_savings) ~= class(1.1)
    fprintf('Please input a number. \n')
    current_f01k_savings = input('How much do you have in your 401k? \n');
end

current_bank_savings = input('How much do you have in your Bank? \n');
while class(current_bank_savings) ~= class(1.1)
    fprintf('Please input a number. \n')
    current_bank_savings = input('How much do you have in your Bank? \n');
end

bsalary = input('What is your salary Pre-tax? \n');
while class(bsalary) ~= class(1.1)
    fprintf('Please input a number. \n')
    bsalary = input('What is your salary Pre-tax? \n');
end

life_expenses = input('What are you current life expenses? \n');
while class(life_expenses) ~= class(1.1)
    fprintf('Please input a number. \n')
    life_expenses = input('What are you current life expenses? \n');
end

age = input('What is your current age? \n');
while class(age) ~= class(1)
    fprintf('Please input an integer. \n')
    age = input('What is your current age? \n');
end

goal = input('What is your finnancial goal? \n');
while class(age) ~= class(1.1)
    fprintf('Please input a number. \n')
    goal = input('What is your finnancial goal? \n');
end

update = input('How often would you like to update your information? \n');
while class(age) ~= class(1)
    fprintf('Please input an integer. \n')
    update = input('How often would you like to update your information? \n');
end

state = input('Where do you currently live? \n', 's');
while class(age) ~= class(1)
    fprintf('Please input a string. \n')
    state = input('Where do you currently live? \n', 's');
end
state = lower(state);
fprintf('\n')

warning('on')

% Determines After Tax Salary, 401k, and the percetnage of Before Tax
% Salary for 401k
[asalary, f01k, f01kp2i] = four01k(bsalary, state);

% Calculates what percent of your salary to invest
p2i = percent2invest(asalary, life_expenses);

% Figure out inital invesment percentages
invest = asalary*p2i;

if invest/2 > 6000 && age+years < 50
    rp2i = (6000/invest)*100;
    np2i = (invest-6000)/invest*100;
elseif invest/2 <= 6000 && age+years < 50 
    rp2i = 50;
    np2i = 50;
elseif invest/2 > 7000 && age+years >= 50
    rp2i = (7000/invest)*100;
    np2i = (invest-7000)/invest*100;
elseif invest/2 <= 7000 && age+years >= 50
    rp2i = 50;
    np2i = 50;
end

fprintf('%f Year Mark (%f Years Old)', 0, age)
fprintf('\n')
fprintf('\n')
fprintf('Investing:')
fprintf('\n')
fprintf('%f percent of After Tax Salary', p2i*100)
fprintf('\n')
fprintf('%f percent of Normal Investments', np2i)
fprintf('\n')
fprintf('%f percent of ROTH IRA Investments', rp2i)
fprintf('\n')
fprintf('%f percent of 401k Investments', f01kp2i)
fprintf('\n')
fprintf('\n')
fprintf('Saving:')
fprintf('\n')
fprintf('%f percent of After Tax Salary', p2i*100)
fprintf('\n')
fprintf('\n')
fprintf('\n')

% This will calculate your projected life earnings
[totali, totali1, totali2, totali3, totals, diff, years, f01kp2i, ff01k, fbsalary, fasalary] = calculate_life(goal, asalary, bsalary, p2i, life_expenses, current_normal_savings, current_roth_savings, current_f01k_savings, current_bank_savings, f01k, f01kp2i, age, update, state);

grid on

xlabel('Time (Years)')
ylabel('Networth (US Dollars)')
title('Investing vs Saving wrt Time')

fprintf('Starting Pre-Tax Salary:')
fprintf('\n')
fprintf('$%f', bsalary)
fprintf('\n')
fprintf('Starting Post-Tax Salary (Including 401k):') 
fprintf('\n')
fprintf('$%f', asalary)
fprintf('\n')
fprintf('Starting Tax Deductions (Including 401k):')
fprintf('\n')
fprintf('$%f', taxbracket(bsalary, state)+f01k)
fprintf('\n')
fprintf('\n')
fprintf('Final Pre-Tax Salary:')
fprintf('\n')
fprintf('$%f', fbsalary)
fprintf('\n')
fprintf('Final Post-Tax Salary (Including 401k):') 
fprintf('\n')
fprintf('$%f', fasalary)
fprintf('\n')
fprintf('Final Tax Deductions (Including 401k):')
fprintf('\n')
fprintf('$%f', taxbracket(fbsalary, state)+ff01k)
fprintf('\n')
fprintf('\n')

fprintf('By the time you are %f years old...', age + years - 1)
fprintf('\n')
fprintf('\n')
fprintf('Investing:')
fprintf('\n')
fprintf(['You will reach your goal of $%f by investing in the stock market ' ...
    'for %f years.'], ...
    goal, fix(years-1))
fprintf('\n')
fprintf(['You will achieve $%f by investing in the stock market with normal' ...
    ' investments for %f years.'], ...
    totali1, fix(years-1))
fprintf('\n')
fprintf(['You will achieve $%f by investing in the stock market with ' ...
    'only ROTH IRA for %f years.'], ...
    totali2, fix(years-1))
fprintf('\n')
fprintf(['You will achieve $%f by investing in the stock market with only ' ...
    '401k for %f years.'], ...
    totali3, fix(years-1))
fprintf('\n')
fprintf('\n')

fprintf('Saving:')
fprintf('\n')
fprintf('You will achieve $%f by saving in a bank for %f years.', ...
    fix(totals), fix(years-1))
fprintf('\n')
fprintf('\n')

if diff > 0
    fprintf('Profit:')
    fprintf('\n')
    fprintf(['Investing with will make you $%f richer compared to ' ...
        'Saving.'], fix(diff))
    fprintf('\n')
    fprintf('\n')
else
    fprintf('Profit:')
    fprintf('\n')
    fprintf('Saving will make you $%f richer compared to Investing.', ...
        fix(-diff))
    fprintf('\n')
    fprintf('\n')
end

% This function calculates how much money is taken from your salary due to
% Federal and State Income Tax. 
% https://taxfoundation.org/state-income-tax-rates-2022/ => This site was
% used for state tax brackets.
function tax = taxbracket(salary, state)
    % Federal tax
    if salary <= 10275
        ftax = 0.1*salary;
    elseif salary > 10275 && salary <= 41775
        ftax = 1027.5 + 0.12*(salary-10275);
    elseif salary > 41775 && salary <= 89075
        ftax = 4807.5 + 0.22*(salary-41775);
    elseif salary > 89075 && salary <= 170050
        ftax = 15213.5 + 0.24*(salary-89075);
    elseif salary > 170050 && salary <= 215950
        ftax = 34647.5 + 0.32*(salary - 170050);
    elseif salary > 214950 && salary <= 539900
        ftax = 49335.5 + 0.35*(salary - 215950);
    elseif salary > 539900
        ftax = 162718 + 0.37*(salary - 539900);
    end

    % This will be used to determine if a state was entered incorrectly
    skip = 0;
    if state == "alabama"
        % Alabama
        if salary <= 500
            stax = 0.02*salary;
        elseif salary > 500 && salary <= 3000
            stax = 10 + 0.04*(salary-500);
        elseif salary > 3000
            stax = 150 + 0.05*(salary-3000);
        end
    elseif state == "alaska"
        % Alaska
        stax = 0;
    elseif state == "arizona"
        % Arizona
        if salary <= 27808
            stax = 0.0259*salary;
        elseif salary > 27808 && salary <= 55615
            stax = 720.2272 + 0.0334*(salary-27808);
        elseif salary > 55615 && salary <= 166843
            stax = 1648.981 + 0.0417*(salary-55615);
        elseif salary > 166843
            stax = 6287.1886 + 0.045*(salary-166843);
        end
    elseif state == "arkansas"
        % Arkansas
        if salary <= 4300
            stax = 0.02*salary;
        elseif salary > 4300 && salary <= 8500
            stax = 86 + 0.04*(salary-4300);
        elseif salary > 8500
            stax = 254 + 0.054*(salary-8500);
        end
    elseif state == "california"
        % California
        if salary <= 9325
            stax = 0.01*salary;
        elseif salary > 9325 && salary <= 22107
            stax = 93.25 + 0.02*(salary-9325);
        elseif salary > 22107 && salary <= 34892
            stax = 348.89 + 0.04*(salary-22107);
        elseif salary > 34892 && salary <= 48435
            stax = 890.61 + 0.06*(salary-34892);
        elseif salary > 48435 && salary <= 61214
            stax = 1703.11 + 0.08*(salary-48435);
        elseif salary > 61214 && salary <= 312686
            stax = 2725.43 + 0.093*(salary-61214);
        elseif salary > 312686 && salary <= 375221
            stax = 26112.326 + 0.103*(salary-312686);
        elseif salary > 375221 && salary <= 625369
            stax = 32553.431 + 0.113*(salary-375221);
        elseif salary > 625369 && salary <= 1000000
            stax = 60820.155 + 0.123*(salary-625369);
        elseif salary > 1000000
            stax = 106899.768 + 0.133*(salary-1000000);
        end
    elseif state == "colorado"
        % Colorado
        stax = 0.0455*salary;
    elseif state == "connecticut"
        % Connecticut
        if salary <= 10000
            stax = 0.03*salary;
        elseif salary > 10000 && salary <= 50000
            stax = 300 + 0.05*(salary-10000);
        elseif salary > 50000 && salary <= 100000
            stax = 2300 + 0.055*(salary-50000);
        elseif salary > 100000 && salary <= 200000
            stax = 5050 + 0.06*(salary-100000);
        elseif salary > 200000 && salary <= 250000
            stax = 11050 + 0.065*(salary-200000);
        elseif salary > 250000 && salary <= 500000
            stax = 14300 + 0.069*(salary-250000);
        elseif salary > 500000
            stax = 31550 + 0.0699*(salary - 500000);
        end
    elseif state == "delaware"
        % Deleware
        if salary <= 5000
            stax = 0.022*salary;
        elseif salary > 5000 && salary <= 10000
            stax = 110 + 0.039*(salary-5000);
        elseif salary > 10000 && salary <= 20000
            stax = 305 + 0.048*(salary-10000);
        elseif salary > 20000 && salary <= 25000
            stax = 785 + 0.052*(salary-20000);
        elseif salary > 25000 && salary <= 60000
            stax = 1045 + 0.0555*(salary-25000);
        elseif salary > 60000
            stax = 2987.5 + 0.066*(salary-60000);
        end
    elseif state == "florida"
        % Florida
        stax = 0;
    elseif state == "georgia"
        % Georgia
        if salary <= 750
            stax = 0.01*salary;
        elseif salary > 750 && salary <= 2250
            stax = 7.5 + 0.02*(salary-750);
        elseif salary > 2250 && salary <= 3750
            stax = 37.5 + 0.03*(salary-2250);
        elseif salary > 3750 && salary <= 5250
            stax = 82.5 + 0.04*(salary-3750);
        elseif salary > 5250 && salary <= 7000
            stax = 142.5 + 0.05*(salary-5250);
        elseif salary > 7000 
            stax = 230 + 0.0575*(salary-7000);
        end
    elseif state == "hawaii"
        % Hawaii
        if salary <= 2400
            stax = 0.014*salary;
        elseif salary > 2400 && salary <= 4800
            stax = 33.6 + 0.032*(salary-2400);
        elseif salary > 4800 && salary <= 9600
            stax = 110.4 + 0.055*(salary-4800);
        elseif salary > 9600 && salary <= 14400
            stax = 374.4 + 0.064*(salary-9600);
        elseif salary > 14400 && salary <= 19200
            stax = 681.6 + 0.068*(salary-14400);
        elseif salary > 19200 && salary <= 24000
            stax = 1008 + 0.072*(salary-19200);
        elseif salary > 24000 && salary <= 36000
            stax = 1353.6 + 0.076*(salary-24000);
        elseif salary > 36000 && salary <= 48000
            stax = 2265.6 + 0.079*(salary-36000);
        elseif salary > 48000 && salary <= 150000
            stax = 3213.6 + 0.0825*(salary-48000);
        elseif salary > 150000 && salary <= 175000
            stax = 11628.6 + 0.09*(salary-150000);
        elseif salary > 175000 && salary <= 200000
            stax = 13878.6 + 0.1*(salary-200000);
        elseif salary < 200000
            stax = 16378.6 + 0.11*(salary-200000);
        end
    elseif state == "idaho"
        % Idaho
        if salary <= 1588
            stax = 0.01*salary;
        elseif salary > 1588 && salary <= 4763
            stax = 15.88 + 0.03*(salary-1588);
        elseif salary > 4763 && salary <= 7939
            stax = 111.13 + 0.045*(salary-4763);
        elseif salary > 7939
            stax = 254.05 + 0.06*(salary-7939);
        end
    elseif state == "illinois"
        % Illinois
        stax = 0.0495*salary;
    elseif state == "indiana"
        % Indiana
        stax = 0.0323*salary;
    elseif state == "iowa"
        % Iowa
        if salary <= 1743
            stax = 0.0033*salary;
        elseif salary > 1743 && salary <= 3486
            stax = 5.7519 + 0.0067*(salary-1743);
        elseif salary > 3486 && salary <= 6972
            stax = 17.43 + 0.0225*(salary-3486);
        elseif salary > 6972 && salary <= 15687
            stax = 95.865 + 0.0414*(salary-6972);
        elseif salary > 15687 && salary <= 26145
            stax = 456.666 + 0.0563*(salary-15687);
        elseif salary > 26145 && salary <= 34860
            stax = 1045.4514 + 0.0596*(salary-26145);
        elseif salary > 34860 && salary <= 52290
            stax = 1564.8654 + 0.0625*(salary-34860);
        elseif salary > 52290 && salary <= 78435
            stax = 2654.2404 + 0.0744*(salary-52290);
        elseif salary > 78435
            stax = 4599.4284 + 0.0853*(salary-78435);
        end
    elseif state == "kansas"
        % Kansas
        if salary <= 15000
            stax = 0.031*salary;
        elseif salary > 15000 && salary <= 30000
            stax = 465 + 0.0525*(salary-15000);
        elseif salary > 30000
            stax = 1252.5 + 0.057*(salary-30000);
        end
    elseif state == "kentucky"
        % Kentucky
        stax = 0.05*salary;
    elseif state == "louisiana"
        % Louisiana
        if salary <= 12500
            stax = 0.0185*salary;
        elseif salary > 12500 && salary <= 50000
            stax = 231.25 + 0.035*(salary-12500);
        elseif salary > 50000
            stax = 1543.75 + 0.0425*(salary-50000);
        end
    elseif state == "maine"
        % Maine
        if salary <= 23000
            stax = 0.058*salary;
        elseif salary > 23000 && salary <= 54450
            stax = 1334 + 0.0675*(salary-23000);
        elseif salary > 54450
            stax = 3456.875 + 0.0715*(salary-54450);
        end
    elseif state == "maryland"
        % Maryland
        if salary <= 1000
            stax = 0.02*salary;
        elseif salary > 1000 && salary <= 2000
            stax = 20 + 0.03*(salary-1000);
        elseif salary > 2000 && salary <= 3000
            stax = 50 + 0.04*(salary-2000);
        elseif salary > 3000 && salary <= 100000
            stax = 90 + 0.0475*(salary-3000);
        elseif salary > 100000 && salary <= 125000
            stax = 4697.5 + 0.05*(salary-150000);
        elseif salary > 125000 && salary <= 150000
            stax = 5947.5 + 0.0525*(salary-250000);
        elseif salary > 150000 && salary <= 250000
            stax = 7260 + 0.055*(salary - 225000);
        elseif salary > 250000
            stax = 12760 + 0.0575*(salary-300000);
        end
    elseif state == "massachusetts"
        % Massachusetts
        stax = 0.05*salary;
    elseif state == "michigan"
        % Michigan
        stax = 0.0425*salary;
    elseif state == "minnesota"
        % Minnesota
        if salary <= 28080
            stax = 0.0535*salary;
        elseif salary > 28080 && salary <= 92230
            stax = 1502.28 + 0.068*(salary-28080);
        elseif salary > 92230 && salary <= 171220
            stax = 5864.48 + 0.0785*(salary-92230);
        elseif salary > 171220
            stax = 12065.195 + 0.0985*(salary-171220);
        end
    elseif state == "mississippi"
        % Mississippi
        if salary <= 5000
            stax = 0;
        elseif salary > 5000 && salary <= 10000
            stax = 0.04*(salary-5000);
        elseif salary > 10000
            stax = 200 + 0.05*(salary-10000);
        end
    elseif state == "missouri"
        % Missouri
        if salary <= 108
            stax = 0;
        elseif salary > 108 && salary <= 1088
            stax = 0.015*(salary-108);
        elseif salary > 1088 && salary <= 2176
            stax = 14.7 + 0.02*(salary-1088);
        elseif salary > 2176 && salary <= 3264
            stax = 36.46 + 0.025*(salary-2176);
        elseif salary > 3264 && salary <= 4352
            stax = 63.66 + 0.03*(salary-3264);
        elseif salary > 4352 && salary <= 5440
            stax = 96.3 + 0.035*(salary-4352);
        elseif salary > 5440 && salary <= 6528
            stax = 134.38 + 0.04*(salary-5440);
        elseif salary > 6528 && salary <= 7616
            stax = 177.9 + 0.045*(salary-6528);
        elseif salary > 7616 && salary <= 8704
            stax = 226.86 + 0.05*(salary-7616);
        elseif salary > 8704
            stax = 281.26 + 0.054*(salary-8704);
        end
    elseif state == "montana"
        % Montana
        if salary <= 3100
            stax = 0.01*salary;
        elseif salary > 3100 && salary <= 5500
            stax = 31 + 0.02*(salary-3100);
        elseif salary > 5500 && salary <= 8400
            stax = 79 + 0.03*(salary-5500);
        elseif salary > 8400 && salary <= 11400
            stax = 166 + 0.04*(salary-8400);
        elseif salary > 11400 && salary <= 14600
            stax = 286 + 0.05*(salary-11400);
        elseif salary > 14600 && salary <= 18800
            stax = 446 + 0.06*(salary-14600);
        elseif salary > 18800
            stax = 698 + 0.0675*(salary-18800);
        end
    elseif state == "nebraska"
        % Nebraska
        if salary <= 3440
            stax = 0.0246*salary;
        elseif salary > 3440 && salary <= 20590
            stax = 84.624 + 0.0351*(salary-3440);
        elseif salary > 20590 && salary <= 33180
            stax = 686.589 + 0.0501*(salary-20590);
        elseif salary > 33180 
            stax = 1317.348 + 0.0684*(salary-33180);
        end
    elseif state == "nevada"
        % Nevada
        stax = 0;
    elseif state == "new hampshire"
        % New Hampshire
        stax = 0;
    elseif state == "new jersey"
        % New Jersey
        if salary <= 20000
            stax = 0.014*salary;
        elseif salary > 20000 && salary <= 35000
            stax = 280 + 0.0175*(salary-20000);
        elseif salary > 35000 && salary <= 40000
            stax = 542.5 + 0.035*(salary-35000);
        elseif salary > 40000 && salary <= 75000
            stax = 717.5 + 0.0525*(salary-40000);
        elseif salary > 75000 && salary <= 500000
            stax = 2555 + 0.0637*(salary-75000);
        elseif salary > 500000 && salary <= 1000000
            stax = 29627.5 + 0.0897*(salary-500000);
        elseif salary > 1000000
            stax = 74477.5 + 0.1075*(salary-1000000);
        end
    elseif state == "new mexico"
        % New Mexico
        if salary <= 5500
            stax = 0.017*salary;
        elseif salary > 5500 && salary <= 11000
            stax = 93.5 + 0.032*(salary-5500);
        elseif salary > 11000 && salary <= 16000
            stax = 269.5 + 0.047*(salary-11000);
        elseif salary > 16000 && salary <= 210000
            stax = 504.5 + 0.049*(salary-16000);
        elseif salary > 210000 
            stax = 10010.5 + 0.059*(salary-210000);
        end
    elseif state == "new york"
        % New York
        if salary <= 8500
            stax = 0.04*salary;
        elseif salary > 8500 && salary <= 11700
            stax = 340 + 0.045*(salary-8500);
        elseif salary > 11700 && salary <= 13900
            stax = 484 + 0.0525*(salary-11700);
        elseif salary > 13900 && salary <= 80650
            stax = 599.5 + 0.0585*(salary-13900);
        elseif salary > 80650 && salary <= 215400
            stax = 4504.375 + 0.0625*(salary-80650);
        elseif salary > 215400 && salary <= 1077550
            stax = 12926.25 + 0.0965*(salary-215400);
        elseif salary > 1077550 && salary <= 5000000
            stax = 96123.725 + 0.103*(salary-1077550);
        elseif salary > 5000000 && salary <= 25000000
            stax = 5000136.075 + 0.109*(salary-5000000);
        end
    elseif state == "north carolina"
        % North Carolina
        stax = 0.0499*salary;
    elseif state == "north dakota"
        % North Dakota
        if salary <= 40525
            stax = 0.011*salary;
        elseif salary > 40525 && salary <= 98100
            stax = 445.775 + 0.0204*(salary-40525);
        elseif salary > 98100 && salary <= 204675
            stax = 1620.305 + 0.0227*(salary-98100);
        elseif salary > 204675 && salary <= 445000
            stax = 4039.5575 + 0.0264*(salary-204675);
        elseif salary > 445000
            stax = 10384.1375 + 0.029*(salary-445000);
        end
    elseif state == "ohio"
        % Ohio
        if salary <= 2500
            stax = 0;
        elseif salary > 25000 && salary <= 44250
            stax = 0.02765*(salary-25000);
        elseif salary > 44250 && salary <= 88450
            stax = 532.2625 + 0.03226*(salary-44250);
        elseif salary > 88450 && salary <= 110650
            stax = 1958.1545 + 0.03668*(salary-88450);
        elseif salary > 110650
            stax = 2772.4505 + 0.0399*(salary-110650);
        end
    elseif state == "oklahoma"
        % Oklahoma
        if salary <= 1000
            stax = 0.0025*salary;
        elseif salary > 1000 && salary <= 2500
            stax = 2.5 + 0.0075*(salary-1000);
        elseif salary > 2500 && salary <= 3750
            stax = 13.75 + 0.0175*(salary-2500);
        elseif salary > 3750 && salary <= 4900
            stax = 35.625 + 0.0275*(salary-3750);
        elseif salary > 4900 && salary <= 7200
            stax = 67.25 + 0.0375*(salary-4900);
        elseif salary > 7200
            stax = 153.5 + 0.0475*(salary-7200);
        end
    elseif state == "oregon"
        % Oregon
        if salary <= 3650
            stax = 0.0475*salary;
        elseif salary > 3650 && salary <= 9200
            stax = 173.375 + 0.0675*(salary-3650);
        elseif salary > 9200 && salary <= 12500
            stax = 548 + 0.0875*(salary-9200);
        elseif salary > 125000 
            stax = 10132.5 + 0.099*(salary-125000);
        end
    elseif state == "pennsylvania"
        % Pennsylvania
        stax = 0.0307*salary;
    elseif state == "rhode island"
        % Rhode Island
        if salary <= 68200
            stax = 0.0375*salary;
        elseif salary > 68200 && salary <= 155050
            stax = 2557.5 + 0.0475*(salary-68200);
        elseif salary > 155050 
            stax = 6682.875 + 0.0599*(salary-155050);
        end
    elseif state == "south carolina"
        % South Carolina
        if salary <= 3200
            stax = 0;
        elseif salary > 3200 && salary <= 6410
            stax = 0.03*(salary-3200);
        elseif salary > 6410 && salary <= 9620
            stax = 96.3 + 0.04*(salary-6410);
        elseif salary > 9620 && salary <= 12820
            stax = 224.7 + 0.05*(salary-9620);
        elseif salary > 12820 && salary <= 16040
            stax = 384.7 + 0.06*(salary-12820);
        elseif salary > 16040
            stax = 577.9 + 0.07*(salary-16040);
        end
    elseif state == "south dakota"
        % South Dakota
        stax = 0;
    elseif state == "tennessee"
        % Tennessee
        stax = 0;
    elseif state == "texas"
        % Texas
        stax = 0;
    elseif state == "utah"
        % Utah
        stax = 0.0495*salary;
    elseif state == "vermont"
        % Vermont
        if salary <= 40950
            stax = 0.0335*salary;
        elseif salary > 40950 && salary <= 99200
            stax = 1371.825 + 0.066*(salary-40950);
        elseif salary > 99200 && salary <= 206950
            stax = 5216.325 + 0.076*(salary-99200);
        elseif salary > 206950
            stax = 13405.325 + 0.0875*(salary-206950);
        end
    elseif state == "virginia"
        % Viginia
        if salary <= 3000
            stax = 0.02*salary;
        elseif salary > 3000 && salary <= 5000
            stax = 60 + 0.03*(salary-3000);
        elseif salary > 5000 && salary <= 17000
            stax = 120 + 0.05*(salary-5000);
        elseif salary > 17000
            stax = 720 + 0.0575*(salary-17000);
        end
    elseif state == "washington"
        % Washington
        stax = 0;
    elseif state == "west virginia"
        % West Virginia
        if salary <= 10000
            stax = 0.03*salary;
        elseif salary > 10000 && salary <= 25000
            stax = 300 + 0.04*(salary-10000);
        elseif salary > 25000 && salary <= 40000
            stax = 700 + 0.045*(salary-25000);
        elseif salary > 40000 && salary <= 60000
            stax = 1375 + 0.06*(salary-40000);
        elseif salary > 60000
            stax = 2575 + 0.065*(salary-60000);
        end
    elseif state == "wisconsin"
        % Wisconsin
        if salary <= 12760
            stax = 0.0354*salary;
        elseif salary > 12760 && salary <= 25520
            stax = 451.704 + 0.0465*(salary-12760);
        elseif salary > 25520 && salary <= 280950
            stax = 1045.044 + 0.053*(salary-25520);
        elseif salary > 280950 
            stax = 14582.834 + 0.0765*(salary-280950);
        end
    elseif state == "wyoming"
        % Wyoming
        stax = 0;
    elseif state == "district of columbia"
        % District of Columbia
        if salary <= 10000
            stax = 0.04*salary;
        elseif salary > 10000 && salary <= 40000
            stax = 400 + 0.06*(salary-10000);
        elseif salary > 40000 && salary <= 60000
            stax = 2200 + 0.065*(salary-40000);
        elseif salary > 60000 && salary <= 250000
            stax = 3500 + 0.085*(salary-60000);
        elseif salary > 250000 && salary <= 500000
            stax = 19650 + 0.0925*(salary-250000);
        elseif salary > 500000 && salary <= 1000000
            stax = 42775 + 0.0975*(salary-500000);
        elseif salary > 1000000
            stax = 91525 + 0.1075*(salary-1000000);
        end
    else
        state = input('Please input a valid state. \n', 's');
        state = lower(state);

        tax = taxbracket(salary, state);
        skip = 1;
    end

    if skip == 0
        tax = ftax + stax;
    end
end

% This function will calculate your salary after federal and state tax.
% (Federal tax is based off of 2022 information and State tax is based on 
% Maryland's 2021 information. (Will use this if statement for 401k
% matching)
function [asalary, f01k, f01kp2i] = four01k(salary, state)
    tax = taxbracket(salary, state);
    f01k = 0.05*salary;

    if 0.05*salary >= 3000
        asalary = salary - tax - 3000;
        f01k = 3000;
        f01kp2i = f01k/salary*100;
    else
        asalary = salary - tax - f01k;
        f01kp2i = 5;
    end
end

% This will calculate the optimum percent of salary to invest/save. If your
% after tax salary is less than your life expenses, you should fix your
% priorities.
function p2i = percent2invest(salary, expenses)
    if salary > expenses
        p2i = (salary - expenses)/salary;
    else
        disp('You need to fix your priorities...')
        return
    end
end

% This calculates your total investments every year with a return rate
% between nothing and 8 percent
function [totali, totali1, totali2, totali3, totals, diff, years, f01kp2i, f01k, bsalary, asalary] = calculate_life(goal, asalary, bsalary, p2i, life_expenses, normal, roth, sf01k, sbank, f01k, f01kp2i, age, updateyears, state)
    % This calculates how much money to invest/save as well as tally your
    % total investments over however many years it takes to reach your goal.
    invest = asalary*p2i;
    totali1 = normal;
    
    % Using roth ira
    totali2 = roth;
    
    % Using 401k
    totali3 = sf01k;
    
    % Total investments
    totali = totali1 + totali2 + totali3;
    
    % Same thing, but for savings
    totals = sbank;
    
    % Tracks years through calculation
    years = 1;

    % Will be used to update you salary and expenses every five years
    update = 1;
    
    % This calculates your total investments every year with a return rate
    % between nothing and 8 percent
    while totali <= goal
        if updateyears == 0
            [asalary, f01k, f01kp2i] = four01k(bsalary, state);
            p2i = percent2invest(asalary, life_expenses);
            invest = asalary*p2i;

        % Check every specifed update years on their annual income and their life
        % expenses until they reach their goal
        elseif update == updateyears
            prompt1 = "What will your new salary be " + string(updateyears) + " years later? \n";
            prompt2 = "What are your new life expenses " + string(updateyears) + " years later? \n";
            prompt3 = "In " + string(updateyears) + " years, what state do you plan to live in? \n";
            bsalary = input(prompt1);
            life_expenses = input(prompt2);
            state = input(prompt3, 's');
            fprintf('\n')
            fprintf('\n')
    
            [asalary, f01k, f01kp2i] = four01k(bsalary, state);
            p2i = percent2invest(asalary, life_expenses);
            invest = asalary*p2i;

            fprintf('%f Year Mark (%f Years Old)', years, age+years)
            fprintf('\n')
            fprintf('\n')
            fprintf('Investing:')
            fprintf('\n')
            fprintf('%f percent of After Tax Salary', p2i*100)
            fprintf('\n')
            fprintf('%f percent of Normal Investments', np2i)
            fprintf('\n')
            fprintf('%f percent of ROTH IRA Investments', rp2i)
            fprintf('\n')
            fprintf('%f percent of 401k Investments', f01kp2i)
            fprintf('\n')
            fprintf('\n')
            fprintf('Saving:')
            fprintf('\n')
            fprintf('%f percent of After Tax Salary', p2i*100)
            fprintf('\n')
            fprintf('\n')
            fprintf('\n')

            % Resets the five year loop 
            update = 0;
        end

        % Simple counter to track every 5 years
        update = update + 1;

        % Generate variable annual stock returns for each stock (Should be
        % different depending on what portfolio has for stocks)
        rate1 = 1 + randi([0 8])/100;
        rate2 = 1 + randi([0 8])/100;
        rate3 = 1 + randi([0 8])/100;
    
        % DO NOT need to calculate tax for stocks since we are not selling
        % any. This if statement will determine how much to split the
        % investments between normal stock portfolio and ROTH IRA taking into
        % account your age at the time.
        if invest/2 > 6000 && age+years < 50
            totali2 = (totali2+6000)*rate2;
            totali1 = (totali1+invest-6000)*rate1;
            
            rp2i = (6000/invest)*100;
            np2i = (invest-6000)/invest*100;
        elseif invest/2 <= 6000 && age+years < 50 
            totali2 = (totali2+invest/2)*rate2;
            totali1 = (totali1+invest/2)*rate1;
    
            rp2i = 50;
            np2i = 50;
        elseif invest/2 > 7000 && age+years >= 50
            totali2 = (totali2+7000)*rate2;
            totali1 = (totali1+invest-7000)*rate1;
    
            rp2i = (7000/invest)*100;
            np2i = (invest-7000)/invest*100;
        elseif invest/2 <= 7000 && age+years >= 50
            totali2 = (totali2+invest/2)*rate2;
            totali1 = (totali1+invest/2)*rate1;
    
            rp2i = 50;
            np2i = 50;
        end
    
        % Tally up 401k investments (Make sure to double because companies will
        % match whatever you put in)
        totali3 = (f01k*2 + totali3)*rate3;
    
        % Tally up total investments
        totali = totali1 + totali2 + totali3;
    
        % Tally up total savings
        totals = invest + totals;
    
        % Track Normal Investments
        normi(years+1) = totali1;
        % Track ROTH IRA
        rothi(years+1) = totali2;
        % Track 401k
        f01ki(years+1) = totali3;
        % Track Total Investments
        ti(years+1) = totali;
        % Track Bank savings
        banks(years+1) = totals;
    
        % Keeps a tally of the number of years.
        years = years + 1;
    end
    
    % Calculates the difference bewteen investing and saving once you have
    % reached your goal.
    diff = totali - totals;

    % Plot the change of portfolio value and bank savings over time
    time = 0:1:years-1;

    hold off
    plot(time, ti, 'g')
    hold on
    plot(time, normi, 'b')
    plot(time, rothi, 'm')
    plot(time, f01ki, 'y')
    plot(time, banks, 'r')

    legend('Total Investments', 'Stock Portfolio', 'ROTH IRA Investments', '401k Investments', 'Bank Savings')

end
