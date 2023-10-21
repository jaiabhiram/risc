from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.keys import Keys

driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()))
file_handler = open("Program.txt", 'r')
file_handler_2 = open("INSTRUCTION_MEM.mem", 'w')
for x in file_handler:
    keys = x
    driver.get("https://luplab.gitlab.io/rvcodecjs/")
    driver.find_element(By.XPATH, "//input[contains(@id,'search-input')]").send_keys(keys)
    driver.find_element(By.XPATH, "//input[contains(@id,'search-input')]").send_keys(Keys.RETURN)
    assembly_code = driver.find_element(By.XPATH, "//div[contains(@id,'hex-data')]")
    file_handler_2.writelines(assembly_code.text[2:])
    file_handler_2.write('\n')

file_handler.close()
file_handler_2.close()

