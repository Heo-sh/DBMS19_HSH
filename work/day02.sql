-- EMPLOYEES 테이블에서 이름이 'Michael'인 사원의 사번, 이름 조회
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME = 'Michael';

-- EMPLOYEES 테이블에서  IT_PROG인 사원들의 정보를 사번, 이름, 직종, 급여 순 조회
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG';

-- EMPLOYEES 테이블에서 급여가 10000 이상 13000이하인 사원을 이름, 급여 순 조회
-- DB에서는 ||, & 등의 기호 대신 AND, OR 등의 글자로 표현한다.
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY >= 10000 AND SALARY <= 13000;

-- EMPLOYEES 테이블에서 06년도에 입사한 사원들의 정보를 사번, 이름, 직종, 입사일 순으로 출력
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE = '2006-01-01'AND HIRE_DATE <= '2006-12-31';

-- EMPLOYEES 테이블에서 2200, 3200, 5000, 6800을 받는 사원들의 정보를
-- 사번, 이름, 직종, 급여 순으로 조회
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE SALARY IN (2200, 3200, 5000, 6800);


/* SQL연산자
 * 1. BETWEEN: A와 B 사이의 값을 조회할 때 사용(이상, 이하 값일 때만 사용 가능)
 * 2. IN: OR을 대신해서 사용하는 연산자
 * 3. LIKE: 유사 검색
 * 		- %: 모든 값을 의미 
 * 			EX) 'M%': M으로 시작하는 모든 데이터
 * 				'%M': M으로 끝나는 모든 데이터
 * 				'%A%': 값의 어디든 A를 포함하는 모든 값
 * 		- _: 하나의 값을 의미, _하나는 하나의 데이터만
 * 			EX) 'A_': A로 시작하는 두글자 데이터
 * 				'__A': A로 끝나는 세글자 데이터
 * 				'_A_': A가 중간에 들어간 세글자 데이터
 * */

-- EMPLOYEES 테이블에서 급여가 5000 이상 6000이하인 사원의 정보를 사번, 이름, 급여 순 조회
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY BETWEEN 5000 AND 6000;

-- 직종이 SA_MAN, IT_PROG인 사원들의 정보를 이름, 직종 순 조회
SELECT FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE JOB_ID IN ('SA_MAN', 'IT_PROG');

-- EMPLOYEES 테이블에서 사원들의 이름 중 M으로 시작하는 사원의 정보를 사번, 이름, 직종 순 조회
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'M%';

-- EMPLOYEES 테이블에서 이름이 d로 끝나는 사원의 사번, 이름, 직종 순 조회
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%d';

-- EMPLOYEES 테이블에서  이름의 어디든지 a가 포함되어 있는 사원의 정보를 이름, 직종 순 조회
SELECT FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%a%';

-- EMPLOYEES 테이블에서 이름의 세번째 글자에 a가 들어가는 사원들의 정보를 사번, 이름 순 조회
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '__a%';

-- EMPLOYEES 테이블에서 이름이 H로 시작하면서 6글자 이상인 사원들의 정보를 사번, 이름 순 조회
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'H_____%';

-- EMPLOYEES 테이블에서 이름에 s가 포함되어 있지 않은 사원들의 정보를 사번, 이름 순 조회
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE NOT FIRST_NAME LIKE '%s%';

/* ORDER BY (정렬)
 * - 질의 결과에 반환되는 행동을 특정 기준으로 정렬하고자 할 때 사용
 * - ORDER BY절은 항상 맨 뒤에 작성
 * - ASC: 오름차순, 기본값이기에 생략 가능
 * - DESC: 내림차순, 생략 불가
 * */

-- EMPLOYEES 테이블에서 급여를 많이 받는 사원순으로 사번, 이름, 급여, 입사일을 출력하되
-- 급여가 같을 경우 입사일이 빠른 순으로 정렬
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, HIRE_DATE
FROM EMPLOYEES
ORDER BY SALARY DESC, HIRE_DATE;

-- 테이블 전체 조회 시 컬럼의 순서를 가지고 정렬이 가능
SELECT * 
FROM EMPLOYEES 
ORDER BY 8 ASC;

-- EMPLOYEES 테이블에서 급여가 15000 이상인 사원들의 사번, 이름, 급여, 입사일을
-- 입사일이 빠른 순으로 조회
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, HIRE_DATE
FROM EMPLOYEES
WHERE SALARY >= 15000
ORDER BY HIRE_DATE;

/* SQL함수
 * - 오라클에서 자체적으로 제공하는 함수
 * - 상황에 맞는 적절한 함수를 사용하기 위해서는 어떤 기능을 하는 함수들이 존재하는 지
 *   파악해야 한다.
 * 
 * 내장함수의 종류
 * - 단일행 함수: 1개의 행의 값이 함수에 적용되어 1개의 행을 반환한다.
 * - 집계 함수: 1개 이상의 행의 값이 함수에 적용되어 1개 이상의 값을 반환
 * 
 * 문자함수
 * - ASCII(''): 지정된 문자를 ASCII값으로 반환하는 함수
 * - CHR(정수): 지정된 정수와 일치하는 ASCII코드를 반환하는 함수
 * - RPAD(): 왼쪽 정렬 후, 오른쪽에 생긴 빈 공백에 특정 문자를 채워 반환하는 함수
 * - LPAD(): 오른쪽 정렬 후, 왼쪽에 생긴 빈 공백에 특정 문자를 채워 반환하는 함수
 * - TRIM(): 문자열의 공백 문자와 특정 문자를 삭제하는 함수
 * - RTRIM, LTRIM: 각각 오른쪽, 왼쪽의 공백 제거 함수
 * - INSTR(): 특정 문자의 위치 반환 함수, INDEX가 아님 -> 0부터가 아닌 1부터 시작
 *            찾는 문자열이 없으면 0을 반환
 * - INITCAP(): 첫 문자를 대문자로 변환하는 함수, 공백이나 /를 구분자로 인식
 * - LENGTH(): 문자열의 길이를 반환하는 함수, 공백도 포함 (자주 사용)
 * - REPLACE(): 첫 번째 지정한 문자를 두번째 지정한 문자로 치환하는 함수 (자주 사용)
 * - UPPER(): 데이터를 대문자로 바꿔주는 함수 (자주 사용)
 * - LOWER(): 데이터를 소문자로 바꿔주는 함수 (자주 사용)
 * */
SELECT ASCII('A') FROM DUAL;
SELECT CHR(65) FROM DUAL;
SELECT RPAD(CITY, 10, '★') FROM LOCATIONS;
SELECT LPAD(CITY, 10, '★') FROM LOCATIONS;
SELECT TRIM('   HELLO   ') FROM DUAL;
SELECT TRIM('Z' FROM 'ZZZHELLOZZZ') FROM DUAL;
SELECT INSTR('HELLO', 'O') FROM DUAL;
SELECT INSTR('HELLO', 'L', 1, 2) FROM DUAL;
-- ('HELLO', 'L', 1(탐색 시작 위치), 2(몇 번째에 나오는 글자를 반환))
SELECT INSTR('HELLO', 'Z') FROM DUAL;
SELECT INITCAP('good morning') FROM DUAL;
SELECT INITCAP('good/morning') FROM DUAL;
SELECT LENGTH('JHON') FROM DUAL;
SELECT REPLACE(FIRST_NAME, 'el', '**') FROM EMPLOYEES;
SELECT UPPER('good morning') FROM DUAL;
SELECT LOWER('GOOD MORNING') FROM DUAL;

/* 숫자함수
 * - ABS(): 절대값을 반환하는 함수
 * - ROUND(): 반올림해주는 함수
 * - FLOOR(): 주어진 데이터보다 작거나 같은 정수 중 최대값을 반환 (자주 사용)
 * - TRUNC(): 버림함수 (자주 사용)
 * - SIGN(): 주어진 값의 음수, 양수, 0의 여부를 판단하는 함수
 *  		  음수면 -1, 양수면 1, 0이면 0을 반환
 * - CEIL(): 주어진 숫자보다 크거나 같은 정수 중 최소값 반환
 * - MOD(): 나눈 후 나머지 반환 함수 (자주 사용)
 * - POWER(): 제곱을 해주는 함수 (자주 사용)
 * */
SELECT -10, ABS(-10) FROM DUAL;
SELECT ROUND(3.141592), ROUND(3.141592, 2) FROM DUAL;
SELECT FLOOR(2), FLOOR(2.1) FROM DUAL;
SELECT TRUNC(3.141592), TRUNC(3.141592, 2) FROM DUAL;
SELECT SIGN(-102), SIGN(107), SIGN(0) FROM DUAL;
SELECT CEIL(2), CEIL(2.1) FROM DUAL;
SELECT MOD(1, 3), MOD(2, 3), MOD(3, 3), MOD(4, 3), MOD(0, 3) FROM DUAL;
SELECT POWER(2, 1), POWER(2, 2), POWER(2, 3) FROM DUAL;

/* 날짜함수
 * - SYSDATE: 현재 날짜를 구해준다.
 * - ADD_MONTHS(): 특정 날짜에 개월 수를 더해주는 함수
 * - MONTHS_BETWEEN(): 두 날짜 사이의 개월 수를 반환하는 함수
 * */
SELECT SYSDATE FROM DUAL;
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 2) FROM DUAL;

-- EMPLOYEES에서 모든 사원의 입사일로부터 6개월 뒤의 날짜를
-- 이름, 입사일, 6개월 뒤의 날짜 순으로 출력
SELECT FIRST_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 6) "6개월 뒤"
FROM EMPLOYEES;

SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) "입사일로부터 개월 수"
FROM EMPLOYEES;

-- EMPLOYEES에서 사원들의 이름, 입사일, 입사 후 오늘까지의 개월 수를 조회하되,
-- 입사기간이 200개월 이상인 사람만 조회하고, 소수점은 한자리까지만 버림으로 출력
SELECT FIRST_NAME, HIRE_DATE, TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE), 1)
FROM EMPLOYEES
WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 200;

-- EMPLOYEES에서 사번이 120번인 사원이 입사 후 3년 6개월이 되는 날 퇴사했다.
-- 이 사원의 사번, 이름, 입사일, 퇴사일 출력
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 42)
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 120;





































