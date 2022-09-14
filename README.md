# FinancialCalculator
This calculator visibly displays the advantages of investing your money versus saving it in a bank account.

A couple of assumptions are made with this calculator:

First, this calculator assumes you can invest in a ROTH IRA and a 401k. While this program is tailored to more mature audiences, future versions of this code can be adapted to have selectable options. In the meantime, it is still a good representation of what your potential growth would like. 

Second, It should be noted that this calculator assumes you invest all of your savings into the S&P500 which has historical annual return rate of 10%. However, I chose to randomize the percentage of annual return from -2 to 14. You can change this to more accuratley match the S&P500 or your portfolio. 

Third, this program does take into account state tax, but only for one state. I chose the state of Maryland, but later versions can allow you to select the state you live in. Also, the tax data is a year or two off from the year 2022 so it should still be relevant, but be sure to update this as time goes on.

Fourth, this program assumes that you earn more than you spend. If you do not fit this criteria, the program will tell you to fix your priorities and quite the program. Future versions could take into account potential losses in profit, but again this is to see the effect of investment growth.

Fifth, this program will update your salary and expenses every 5 years. You can manually change this to update as frequently as every 1 year or as few as 100 years. In hindsight, the more often you update your information, the more accurate the program.

What does the program tell you?
You input your current investment savings, ROTH IRA savings, 401k savings, bank savings, salary before tax, life expenses, age, and savings goal. 

The program will then effectively investment your savings into your current investment portfolio, your ROTH IRA, and 401k. It will ask you to update your before tax salary and life expenses every 5 years to try and produce a more accurate reading. 

Once you hit your financial goal, the program will output several items...
1. An "Investing:" heading will appear followed by 4 strings that tell you how long it took to achieve your financial goal and how much money you will achieve by investing in your normal investment portfolio, your ROTH IRA, and your 401k.
2. A "Saving:" heading will appear followed by a string displaying how much you saved over the same course of time as investing.
3. A "Profit:" heading will appear followed by a string displaying how much MORE you made by investing in comparison to saving.
4. A graph will appear displaying the growth rates of your portfolios in relation to eachother, as well as when you hit 1 million dollar mile markers. 

Things to Improve:
1. Future versions of this code can be adapted to have selectable options such as whether or not you have a ROTH IRA or 401k.
2. Future versiions can allow you to select the state you live in to account for state tax. 
3. Future versions could take into account potential losses in profit assuming you spend more than you make. 

Hope you enjoy the code!