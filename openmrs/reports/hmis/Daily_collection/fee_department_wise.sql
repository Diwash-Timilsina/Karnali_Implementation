select 
person_details.identifier as 'Patient Id',
person_details.Name,
person_details.Date as 'Visit Date',
vt.name as 'Visit Type',
person_details.User as 'By User',
vt.visit_fee as fee from

(SELECT 
    pi.identifier,
    IF(pn.middle_name IS NULL,
        CONCAT(pn.given_name, ' ', pn.family_name),
        CONCAT(pn.given_name, ' ', pn.middle_name, ' ', pn.family_name)) AS 'Name',
    v.date_started AS 'Date',
    v.visit_type_id as 'Type',
    u.username AS 'User'

FROM
    patient_identifier pi
        JOIN
    person_name pn ON pn.person_id = pi.patient_id
        JOIN
        
    visit v ON v.patient_id = pn.person_id
        AND CAST(v.date_started AS DATE) BETWEEN  '#startDate#' AND '#endDate#'
        INNER JOIN
    users u ON u.user_id = v.creator ) person_details  
        left join
	visit_type vt ON vt.visit_type_id = person_details.type
    
    order by person_details.User,vt.name 