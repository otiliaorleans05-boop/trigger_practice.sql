-- 1. Tạo database và chọn database để làm việc
CREATE DATABASE IF NOT EXISTS company;
USE company;

-- Xóa bảng cũ nếu đã tồn tại để tránh xung đột
DROP TABLE IF EXISTS employees;

-- 2. Tạo bảng employees
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
);

-- 3. Tạo Trigger tự động phân loại phòng ban theo mức lương
DELIMITER //

DROP TRIGGER IF EXISTS update_department //

CREATE TRIGGER update_department
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary >= 5000 THEN
        SET NEW.department = 'Management';
    ELSEIF NEW.salary >= 3000 THEN
        SET NEW.department = 'Sales';
    ELSE
        SET NEW.department = 'Support';
    END IF;
END //

DELIMITER ;

-- 4. Chèn dữ liệu mẫu để kiểm tra hoạt động của Trigger
INSERT INTO employees (name, department, salary)
VALUES 
    ('John Doe', 'A', 3500),
    ('Jane Smith', 'A', 2000),
    ('David Johnson', 'A', 6000);

-- 5. Kiểm tra kết quả sau khi chèn (các giá trị 'A' sẽ được trigger đổi tự động)
SELECT * FROM employees;