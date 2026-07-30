#Deposit Type vs Cancellation
USE hotel_bookings⁠;
SELECT
    deposit_type,
    COUNT(*) AS total_bookings,
    SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) AS canceled_bookings,
    SUM(CASE WHEN is_canceled = 0 THEN 1 ELSE 0 END) AS successful_bookings,
    ROUND(
        SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate_pct,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(AVG(adr), 2) AS avg_adr
FROM hotel_bookings
GROUP BY deposit_type
ORDER BY cancellation_rate_pct DESC;
/*
The "Non Refund" deposit type has the highest cancellation rate among 
all deposit types, making deposit type a strong factor in predicting booking cancellations
*/
SELECT
    lead_time_category,
    COUNT(*) AS total_bookings,
    SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) AS canceled_bookings,
    SUM(CASE WHEN is_canceled = 0 THEN 1 ELSE 0 END) AS successful_bookings,
    ROUND(
        SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate_pct,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(AVG(lead_time), 2) AS avg_lead_time
FROM hotel_bookings
GROUP BY lead_time_category
ORDER BY cancellation_rate_pct DESC;
#Bookings made further in advance have a higher cancellation rate. This suggests that longer lead times increase the likelihood of cancellation..
SELECT
    market_segment,
    COUNT(*) AS total_bookings,
    SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) AS canceled_bookings,
    SUM(CASE WHEN is_canceled = 0 THEN 1 ELSE 0 END) AS successful_bookings,
    ROUND(
        SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate_pct,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(AVG(adr), 2) AS avg_adr
FROM hotel_bookings
GROUP BY market_segment
ORDER BY total_bookings DESC;
/*
The Online TA segment contributes the highest number of bookings and also records the highest number of cancellations,
 indicating that online travel agencies have the greatest impact on hotel booking behavior.
 */
 SELECT
    market_segment,
    COUNT(*) AS bookings,
    ROUND(SUM(revenue),2) AS total_revenue
FROM clean_hotel_booking
GROUP BY market_segment
ORDER BY total_revenue DESC;
/*
The Online TA segment generated the highest revenue, indicating that online travel agencies are the hotel's most profitable booking channel.
 Direct bookings also contribute significantly, while other market segments generate comparatively lower revenue. 
This insight can help hotel management focus marketing efforts on the most profitable channels while developing strategies to improve the performance of lower-performing segments.
*/
SELECT
    hotel,
    COUNT(*) AS bookings,
    ROUND(SUM(revenue),2) AS total_revenue,
    ROUND(AVG(adr),2) AS avg_daily_rate
FROM clean_hotel_booking
GROUP BY hotel;
/*
The comparison between City Hotel and Resort Hotel shows clear differences in booking volume and revenue. City Hotels generally receive more bookings due to higher demand from business and short-stay travelers,
 while Resort Hotels often generate higher revenue per booking because of longer stays and higher average daily rates (ADR).
 This comparison helps identify which hotel type contributes more to overall business performance and supports better pricing and marketing decisions.
 */
 SELECT
    month,
    ROUND(SUM(revenue),2) AS monthly_revenue
FROM clean_hotel_booking
GROUP BY month
ORDER BY MIN(arrival_date_month);
/*
The monthly revenue trend shows clear seasonal fluctuations throughout the year.
 Revenue reaches its peak during high-demand months, indicating periods of increased customer activity,
 while lower revenue in other months suggests off-peak seasons. Understanding these trends helps hotel management optimize pricing strategies, 
 promotional campaigns,and resource allocation to maximize revenue throughout the year.
 */
 SELECT
    country,
    COUNT(*) AS bookings,
    ROUND(SUM(revenue),2) AS total_revenue
FROM clean_hotel_booking
GROUP BY country
ORDER BY bookings DESC
LIMIT 10;
/*
The Top 10 Countries analysis identifies the countries that contribute the highest number of hotel bookings.
 The leading countries represent the hotel's primary customer markets and have the greatest impact on overall demand.
 This insight helps hotel management identify key international markets,improve targeted marketing strategies, and strengthen customer acquisition efforts in high-performing countries.
 */
 SELECT
    customer_type,
    COUNT(*) AS bookings,
    ROUND(AVG(revenue),2) AS avg_revenue,
    ROUND(AVG(adr),2) AS avg_adr
FROM clean_hotel_booking
GROUP BY customer_type
ORDER BY bookings DESC;
/*
The customer type analysis shows that Transient customers account for the majority of hotel bookings, making them the primary source of revenue. 
In contrast, Repeated guests represent a smaller portion of bookings but demonstrate customer loyalty and long-term value.
 Increasing customer retention through loyalty programs and personalized services can encourage more repeat visits and improve overall business performance.
 */