--: 주석;
/*
 * 여러줄 주석
 * */

/* DML(DataManipulationLanguage)
 * - SELECT(조회)
 * 		- 열(COLUMN)을 기준으로 조회
 * - INSERT(추가)
 * - UPDATE(수정)
 * - DELETE(삭제)
 * */

-- SELECT(조회)
-- SELECT 컬럼명1, 컬럼명2, 컬럼명3 FROM 테이블명;

-- EMPLOYEES 테이블의 모든 정보 조회
SELECT * FROM EMPLOYEES;

-- DEPARTMENTS 테이블의 모든 정보 조회
SELECT * FROM DEPARTMENTS;

-- EMPLOYEES 테이블에서 특정 내용(이름, 직종, 급여)만 조회
SELECT FIRST_NAME, JOB_ID, SALARY FROM EMPLOYEES;

-- EMPLOYEES 테이블에서 사번, 이름, 입사일, 급여 조회
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE, SALARY 
FROM EMPLOYEES;

-- 컬럼에 없는 정보 출력하기
-- SELECT절에서 간단한 연산이 가능하다. 이 때, 이름을 붙일 수 있다.
-- 사원테이블에서 사번, 이름, 직종, 급여, 보너스 금액을 출력
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY, SALARY * COMMISSION_PCT "BONUS"
FROM EMPLOYEES;

-- WHERE절(조건부여)
-- - 무조건 FROM 뒤에서 사용
-- - 사용자가 원하는 데이터를 검색할 때 조건을 통해 결과를 간추릴 수 있다.
-- WHERE절의 구성
-- - WHERE 컬럼명 조건식;
-- - 비교연산자 (=, >, <, ...)
-- - 문자, 숫자(조건식의 오른쪽에 위치)
SELECT EMPLOYEE_ID, FIRST_NAME 
FROM EMPLOYEES
WHERE EMPLOYEE_ID > 200;

-- EMPLOYEES 테이블에서 급여가 10000 이상인 사원들의 정보를 사번, 이름, 급여 순으로 출력
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY >= 10000;


