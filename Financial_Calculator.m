clear all
clc

fprintf('Remember to pay yourself first.')
fprintf('\n')
fprintf('Mental health and happiness should be prioritized.')
fprintf('\n')
fprintf('\n')

% Input your current savings, your salary before tax, how much you
% spend annually, and you goal
current_normal_savings = 10000;
current_roth_savings = 0;
current_f01k_savings = 0;
current_bank_savings = 0;

bsalary = 40000;
life_expenses = 6000;
age = 21;
goal = 2000000;

% Determines After Tax Salary, 401k, and the percetnage of Before Tax
% Salary for 401k
[asalary, f01k, f01kp2i] = four01k(bsalary);

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
[totali, totali1, totali2, totali3, totals, diff, years, f01kp2i, ff01k, fbsalary, fasalary] = calculate_life(goal, asalary, p2i, current_normal_savings, current_roth_savings, current_f01k_savings, current_bank_savings, f01k, f01kp2i, age);

grid on

xlabel('Time (Years)')
ylabel('Networth (US Dollars)')
title('Investing vs Saving wrt Time (Years)')

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
fprintf('$%f', taxbracket(bsalary)+f01k)
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
fprintf('$%f', taxbracket(fbsalary)+ff01k)
fprintf('\n')
fprintf('\n')

fprintf('By the time you are %f years old...', age + years)
fprintf('\n')
fprintf('\n')
fprintf('Investing:')
fprintf('\n')
fprintf(['You will reach your goal of $%f by investing in the stock market ' ...
    'for %f years.'], ...
    goal, fix(years))
fprintf('\n')
fprintf(['You will achieve $%f by investing in the stock market with normal' ...
    ' investments for %f years.'], ...
    totali1, fix(years))
fprintf('\n')
fprintf(['You will achieve $%f by investing in the stock market with ' ...
    'only ROTH IRA for %f years.'], ...
    totali2, fix(years))
fprintf('\n')
fprintf(['You will achieve $%f by investing in the stock market with only ' ...
    '401k for %f years.'], ...
    totali3, fix(years))
fprintf('\n')
fprintf('\n')

fprintf('Saving:')
fprintf('\n')
fprintf('You will achieve $%f by saving in a bank for %f years.', ...
    fix(totals), fix(years))
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
% Federal and State Income Tax. (Again State Tax is based off of Maryland)
function tax = taxbracket(salary)
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

    if salary <= 1000
        stax = 0.02*salary;
    elseif salary > 1000 && salary <= 2000
        stax = 20 + 0.03*(salary-1000);
    elseif salary > 2000 && salary <= 3000
        stax = 50 + 0.04*(salary-2000);
    elseif salary > 3000 && salary <= 150000
        stax = 90 + 0.0475*(salary-3000);
    elseif salary > 150000 && salary <= 175000
        stax = 7072.5 + 0.05*(salary-150000);
    elseif salary > 175000 && salary <= 225000
        stax = 8322.5 + 0.0525*(salary-175000);
    elseif salary > 225000 && salary <= 300000
        stax = 10947.5 + 0.055*(salary - 225000);
    elseif salary > 300000
        stax = 15072.5 + 0.0575*(salary-300000);
    end

    tax = ftax + stax;
end

% This function will calculate your salary after federal and state tax.
% (Federal tax is based off of 2022 information and State tax is based on 
% Maryland's 2021 information. (Will use this if statement for 401k
% matching)
function [asalary, f01k, f01kp2i] = four01k(salary)
    tax = taxbracket(salary);
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
function [totali, totali1, totali2, totali3, totals, diff, years, f01kp2i, f01k, bsalary, asalary] = calculate_life(goal, asalary, p2i, normal, roth, sf01k, sbank, f01k, f01kp2i, age)
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
    
    % This generates a plot of your projected investments every year towards
    % your goal.
    hold off
    plot(0, totali, 'go')
    hold on
    plot(0, totali1, 'bo')
    plot(0, totali2, 'mo')
    plot(0, totali3, 'yo')
    
    % Helps to create markers at specified increments
    tally = 1;
    
    % Tracks years through calculation
    years = 1;

    % Will be used to update you salary and expenses every five years
    update = 1;
    
    % This calculates your total investments every year with a return rate
    % between nothing and 8 percent
    while totali <= goal
        % Check every 5 years on their annual income and their life
        % expenses until they reach their goal
        if update == 5
            bsalary = input('What is your new salary 5 years later? \n');
            life_expenses = input('What is your new life expenses later? \n');
            fprintf('\n')
            fprintf('\n')
    
            [asalary, f01k, f01kp2i] = four01k(bsalary);
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
        rate1 = 1 + randi([-2 14])/100;
        rate2 = 1 + randi([-2 14])/100;
        rate3 = 1 + randi([-2 14])/100;
    
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
    
        % Plot Normal Investments
        plot(years, totali1, 'bo')
        % Plot ROTH IRA
        plot(years, totali2, 'mo')
        % Plot 401k
        plot(years, totali3, 'yo')
        % Plot Total Investments
        plot(years, totali, 'go')
        % Plot normal bank savings
        plot(years, totals, 'ro')
    
        % Create milestone markers every specfied amount of dollars
        increments = 1000000;
        if totali >= increments*tally
            xline(years)
            tally = tally + 1;
        elseif totali <= totals && totals >= increments*tally
            xline(years)
            tally = tally + 1;
        end
    
        % Keeps a tally of the number of years.
        years = years + 1;
    end
    
    % Calculates the difference bewteen investing and saving once you have
    % reached your goal.
    diff = totali - totals;
end
