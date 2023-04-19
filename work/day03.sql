/*	집계함수
 * 	- 1개 or 2개 이상의 행의 값이 함수에 적용되어서 1개의 값으로 반환
 * 
 * 	집계함수 종류
 * 	- COUNT(): 행들의 개수를 반환
 * 	- MIN(): 행들의 최소값 반환
 *  - MAX(): 행들의 최대값 반환
 * 	- SUM(): 행들의 합계 반환
 * 	- AVG(): 행들의 평균 반환
 * */
 
-- 일반적으로 집계함수와 일반컬럼은 같이 사용불가
SELECT COUNT(*) FROM EMPLOYEES; 

-- 집계함수는 NULL값을 세지 않는다.
SELECT COUNT(COMMISSION_PCT) FROM EMPLOYEES;

-- 사원테이블에서 직종이 'SA_REP'인 직원들의 평균 급여, 급여 최고액,
-- 급여최저액, 급여의 총합을 출력
SELECT AVG(SALARY), MAX(SALARY), MIN(SALARY), SUM(SALARY)
FROM EMPLOYEES
WHERE JOB_ID = 'SA_REP';

-- DISTINCT: 중복된 값은 세지 않음
SELECT COUNT(DISTINCT DEPARTMENT_ID) FROM EMPLOYEES;

-- 부서번호가 80번인 사원들의 급여의 평균을 소수점 한자리까지 반올림하여 출력
SELECT ROUND(AVG(SALARY), 1)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;

-- 로그인에 관한 간단한 쿼리문
-- SELECT COUNT(*) FROM "USER" WHERE ID = AND PW = ;

/*GROUP BY (그룹화)
 * - 특정 테이블에서 소그룹을 만들어서 결과를 분산시켜 얻고자 할 때
 * - ~별 (EX: 부서별 인원 수, 부서별 급여 평균, 직종별 급여 평균, ETC)
 * - SELECT절의 컬럼명과 GROUP BY 뒤에 올 컬럼명이 일치해야 한다.
 * */

-- 각 부서별 급여의 평균, 총 합 출력
SELECT DEPARTMENT_ID, AVG(SALARY), SUM(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY 1; -- 조회하려는 컬럼을 SELECT절에 있는 컬럼에 순서를 매겨서 사용 가능

-- 부서별 급여의 합계를 합계를 기준으로 내림차순 조회
SELECT DEPARTMENT_ID, SUM(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY 2 DESC;

/*HAVING절
 * - GROUP BY로 집계된 값 중 WHERE절처럼
 *   특정 조건을 추가한다고 생각하면 된다.
 * */

-- 각 부서별 급여의 최대값, 최소값, 인원 수(COUNT(*)) 출력을 하되,
-- 급여의 최대값이 8000 이상인 결과만 출력
SELECT DEPARTMENT_ID, MAX(SALARY), MIN(SALARY), COUNT(*) 
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING SUM(SALARY) >= 8000;

-- 각 부서별 인원 수가 20명 이상인 부서의 정보를 부서번호, 급여의 합,
-- 급여의 평균, 인원수 순으로 출력하되, 급여의 평균은 소수점 두번 째 자리까지 반올림하여 출력
SELECT DEPARTMENT_ID, SUM(SALARY), ROUND(AVG(SALARY), 2), COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 20;

-- 부서별, 직종별로 그룹화 하여 결과를 부서번호, 직종, 인원 수 순으로 출력하되,
-- 직종이 'MAN'으로 끝나는 경우에만 출력
SELECT DEPARTMENT_ID, JOB_ID, COUNT(*)
FROM EMPLOYEES
WHERE JOB_ID LIKE '%MAN'
GROUP BY DEPARTMENT_ID, JOB_ID;
-- HAVING JOB_ID LIKE '%MAN';

-- 각 부서별 평균 급여를 소수점 한자리까지 버림으로 출력하되,
-- 평균 급여가 10000 미만인 부서만 조회해야 하며,
-- 부서번호가 50번 이하인 부서만 조회
SELECT DEPARTMENT_ID, TRUNC(AVG(SALARY), 1)
FROM EMPLOYEES
WHERE DEPARTMENT_ID <= 50 -- 집계함수가 아니니 WHERE절 사용
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) < 10000 -- 집계함수 HAVING절 사용
ORDER BY 2 DESC;

SELECT DEPARTMENT_ID, TRUNC(AVG(SALARY), 1)
FROM EMPLOYEES
WHERE DEPARTMENT_ID <= 50 -- 집계함수가 아니니 WHERE절 사용
GROUP BY DEPARTMENT_ID
HAVING 2 < 10000 -- 집계함수 HAVING절 사용
ORDER BY 2 DESC;

/* WHERE절 -> 전체 테이블에 대한 조건
 * HAVING절 -> 그룹화를 진행하고 난 결과에 대한 조건
 * */

-- 각 부서별 부서번호, 급여총합, 평균, 인원수 순 출력하되,
-- 급여의 합이 30000 이상인 경우에만 출력해야 하며,
-- 급여의 평균은 소수점 2번째 자리까지 반올림하여 출력
SELECT DEPARTMENT_ID, SUM(SALARY), ROUND(AVG(SALARY), 2), COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING SUM(SALARY) >= 30000;

/* SUBQUERY
 * - SQL문 안에 또 다른 SQL문이 포함되어 있는 형태
 * - 여러 번 DB접속이 필요한 상황을 한번으로 줄여 속도 증가가 가능함
 * 
 * SUBQUERY 사용하는 곳
 * - WHERE절, HAVING절
 * - SELECT, DELETE문의 FROM절
 * - UPDATE문의 SET절
 * - INSERT문의 INTO절
 * */

-- 이름이 'Michael'이고, 직종이 'MK_MAN'인 사원의 급여보다
-- 많이 받는 사원들의 정보를 사번, 이름, 직종, 급여 순 출력
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT SALARY
				FROM EMPLOYEES
				WHERE FIRST_NAME = 'Michael' AND JOB_ID = 'MK_MAN');

-- 사번이 150번인 사원의 급여와 같은 급여 받는 사원들의 정보를
-- 사번, 이름, 급여 순 출력
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY = (SELECT SALARY
				FROM EMPLOYEES
				WHERE EMPLOYEE_ID = 150);

-- 급여가 회사의 평균 급여 이상인 사람들의 이름과 급여를 조회 하세요
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY >= (SELECT AVG(SALARY)
				FROM EMPLOYEES);

-- 사번이 111번인 사원의 직종과 같고, 사번이 159번인 사원의 급여보다 많이 받는
-- 사원들의 정보를 사번, 이름, 직종, 급여 순 출력
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY 
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID
				FROM EMPLOYEES
				WHERE EMPLOYEE_ID = 111)
				AND SALARY > (SELECT SALARY
							  FROM EMPLOYEES
							  WHERE EMPLOYEE_ID = 159);

-- 직종 별 평균 급여를 출력하되,
-- 평균 급여가 Bruce사원의 급여보다 많이 받는 직종만 조회
SELECT JOB_ID, AVG(SALARY)
FROM EMPLOYEES
GROUP BY JOB_ID
HAVING AVG(SALARY) > (SELECT SALARY
 					  FROM EMPLOYEES
					  WHERE FIRST_NAME = 'Bruce');

-- 사원 테이블에서 급여가 가장 적은 사람의 사번, 이름, 급여를 출력
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY = (SELECT MIN(SALARY)
				FROM EMPLOYEES);

-- 137번 사원보다 급여가 크거나 같고, 149번 사원보다는 작거나 같은
-- 사원의 이름과 급여를 조회
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY BETWEEN (SELECT SALARY
				 	  FROM EMPLOYEES
				 	  WHERE EMPLOYEE_ID = 137)
				 	  AND (SELECT SALARY
		  			  	   FROM EMPLOYEES
					  	   WHERE EMPLOYEE_ID = 149);

/* JOIN
 * 
 * 제약 조건
 * - PRIMARY KEY
 *   - 중복 X
 *   - NULL 값 허용 X
 * - FOREIGN KEY
 *   - 다른 테이블의 PK 의미
 *   - 테이블끼리 관계를 맺을 때 사용
 *   - 중복 가능
 * */












