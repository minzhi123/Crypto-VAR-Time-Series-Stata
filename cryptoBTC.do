gen time = mdy(06,23,2017) + _n -1
format time %d
tsset time, daily

dfuller dominance
dfuller eth
dfuller ltc
dfuller xrp

dfuller D.dominance
dfuller D.eth
dfuller D.ltc
dfuller D.xrp

reg eth dominance, r
predict e1, residual
dfuller e1

reg ltc dominance, r
predict e2, residual
dfuller e2

reg xrp dominance, r
predict e3, residual
dfuller e3
* ETH and LTC have long term relationship with Bitcoin Dominance, but the XRP is not cointegrated with dominance.

varsoc eth dominance /* lag = 2 */
varsoc ltc dominance /* lag = 3 */
varsoc xrp dominance /* lag = 4 */

vec eth dominance, rank(1) lags(2)
vecstable, graph
estimate store eth_1

forecast create fcast_eth1, replace
forecast estimate eth_1
forecast solve, begin(d(15feb2019)) prefix(f_eth_1_)
tsline f_eth_1_eth eth if time >= d(15feb2019)

vec ltc dominance, rank(1) lags(3)
estimate store ltc_1
forecast create fcast_ltc1, replace
forecast estimate ltc_1
forecast solve, begin(d(15feb2019)) prefix(f_ltc_1_)
tsline f_ltc_1_ltc ltc if time >= d(15feb2019)

vec xrp dominance, rank(1) lags(4)
estimate store xrp_1
forecast create fcast_xrp1, replace
forecast estimate xrp_1
forecast solve, begin(d(15feb2019)) prefix(f_xrp_1_)
tsline f_xrp_1_xrp xrp if time >= d(15feb2019)
