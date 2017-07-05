# 小测试

## 领域模型

Contract（合同）: start_date, end_date
has_many :renting_phases

RentingPhase（交租阶段）: start_date, end_date, price (月租金), cycles (几个月交一次租金)

Invoice（账单）: start_date, end_date, due_date（交租日期）, total (一共多少钱)
has_many :line_items

LineItem（账单明细）: start_date, end_date, unit_price（单价：月租金或日租金）, units（月数或天数）, total

每个model都可以添加你认为需要的字段。


## 题目

实现generate_contract()方法和generate_invoices()方法：
contract = Contract.generate_contract(…) # 生成并保存合同
invoices = contract.generate_invoices # 一次生成所有账单

比如合同（8.5 - 12.10）有2个交租阶段，8.5 - 10.4，10.5 - 12.10，租金月付，则需要生成5个账单：（8.5 - 9.4，9.5 - 10.4），（10.5 - 11.4，11.5 - 12.4，12.5 - 12.10）


## 要求

交租阶段的起止日期可以是合同内的任何一天，不一定是月初（1号）或月末（31号）。
一个交租阶段内可以有一个或多个账单，账单的起止日期不能跨交租阶段。
每个账单周期内，每满一个月的部分按整月收（如8.5 - 9.4），不满一个月的部分（如12.5 - 12.10）按日均摊（日租金 = 月租金 * 12 / 365.0）。
交租日期为“上个月的15日”，比如8.5 - 9.4的账单，交租日期为7月15日。
