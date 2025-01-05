/*
GoodThought NGO has been a catalyst for positive change, focusing its efforts on education, healthcare,
and sustainable development to make a significant difference in communities worldwide. With this mission,
GoodThought has orchestrated an array of assignments aimed at uplifting underprivileged populations and fostering long-term growth.

This project offers a hands-on opportunity to explore how data-driven insights can direct and enhance these humanitarian efforts.
In this project, you'll engage with the GoodThought PostgreSQL database, which encapsulates detailed records of assignments, funding,
impacts, and donor activities from 2010 to 2023. This comprehensive dataset includes:

Assignments table:
Details about each project, including its name, duration (start and end dates), budget, geographical region, and the impact score.
Donations table:
Records of financial contributions, linked to specific donors and assignments, highlighting how financial support is allocated and utilized.
Donors table:
Information on individuals and organizations that fund GoodThought’s projects, including donor types.
*/



/*
Identify the assignment with the highest impact score in each region, ensuring that each listed assignment has received at least one donation.
The output should include four columns: 1) assignment_name, 2) region, 3) impact_score, and 4) num_total_donations, sorted by region in ascending order.
Include only the highest-scoring assignment per region, avoiding duplicates within the same region. Save the result as top_regional_impact_assignments.
*/

WITH donation_details AS (
    SELECT
        d.assignment_id,
        ROUND(SUM(d.amount), 2) AS rounded_total_donation_amount,
        dn.donor_type
    FROM
        donations d
    JOIN donors dn ON d.donor_id = dn.donor_id
    GROUP BY
        d.assignment_id, dn.donor_type
)
SELECT
    a.assignment_name,
    a.region,
    dd.rounded_total_donation_amount,
    dd.donor_type
FROM
    assignments a
JOIN
    donation_details dd ON a.assignment_id = dd.assignment_id
ORDER BY
    dd.rounded_total_donation_amount DESC
LIMIT 5;

