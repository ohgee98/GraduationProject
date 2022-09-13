#!/usr/bin/env python
# coding: utf-8

# In[ ]:


import sys
sys.path.insert(0, '/Library/Frameworks/Python.framework/Versions/3.9/lib/python3.9/site-packages')
import os
import subprocess
import time
from multiprocessing import Process
from selenium import webdriver


programmersPage = "https://programmers.co.kr/learn/challenges"
options = webdriver.ChromeOptions()
options.add_argument('headless')
options.add_argument('window-size=1920x1080')
options.add_argument("disable-gpu")

driver = webdriver.Chrome('/Users/eanzero/crawler/chromedriver', options=options)


flag = sys.argv[1]


if os.path.isfile("/Users/eanzero/KOE_project/crawlerCount.txt") == True:
    f = open("/Users/eanzero/KOE_project/crawlerCount.txt",mode="r",encoding="utf=8")
    crawlerCount = f.read()
    crawlerCount = int(crawlerCount)
    f.close()
    if flag == "total":
        for i in range(crawlerCount):
            subprocess.run("docker start crawler" + str(i+1).zfill(3),shell=True)
    else: #####################설정!!!!!!!!!!!!!!!!!!!
        subprocess.run("docker start crawler" + "001",shell=True)
        subprocess.run("docker start crawler" + "005",shell=True)
        subprocess.run("docker start crawler" + "009",shell=True)
else:
    crawlerCount = 0

    
    
if flag == "total":
        for i in range(crawlerCount):
            subprocess.run("docker start crawler" + str(i+1).zfill(3),shell=True)    

while True:
    driver.get(programmersPage)
    bigProbs = {}
    for title in driver.find_elements_by_class_name("col-item"):
        bigProbs[title.find_element_by_class_name("card-title").text.replace("/","_").replace(" ","+")] = title.find_element_by_tag_name("a").get_attribute("href")



    for title in bigProbs:
        driver.get(bigProbs[title])
        smallProbs = {}
        for stitle in driver.find_elements_by_class_name("col-item"):
            smallProbs[stitle.find_element_by_class_name("title").text.replace("/","_").replace(" ","+")] = stitle.find_element_by_tag_name("a").get_attribute("href")
        probLink = bigProbs[title]
        bigProbs[title] = (probLink,smallProbs)

    # In[12]:
    category = {}

    for prob in bigProbs:
        categoryList = {}
        for stitle in bigProbs[prob][1]:
            os.makedirs('/Users/eanzero/KOE_project/programmers/', exist_ok=True)
            os.makedirs('/Users/eanzero/KOE_project/meta/', exist_ok=True)
            if os.path.isdir('/Users/eanzero/KOE_project/programmers/' + prob  + "/" + stitle) == True:
                categoryList[stitle] = True 
            else:    
                os.makedirs('/Users/eanzero/KOE_project/programmers/' + prob  + "/" + stitle, exist_ok=True)
                os.makedirs('/Users/eanzero/KOE_project/meta/' + prob  + "/" + stitle, exist_ok=True)
                categoryList[stitle] = False
        category[prob] = categoryList

    # In[13]:


    # In[12]:


    commands = {}
    infolist = []


    for prob in bigProbs:
        batch = []
        for stitle in bigProbs[prob][1]:
            if category[prob][stitle] == True:
                continue
            prob = prob.replace("(","^")
            prob = prob.replace(")","@")
            stitle = stitle.replace("(","^")
            stitle = stitle.replace(")","@")
            crawlerCount = crawlerCount + 1
            command = "docker run --name crawler" + str(crawlerCount).zfill(3) + " -v /:/usr/src/app py_crawler python3 py_crawler.py "+ prob + " " + stitle + " &"
            prob = prob.replace("^","(")
            prob = prob.replace("@",")")
            stitle = stitle.replace("^","(")
            stitle = stitle.replace("@",")")
            infolist.append(prob+":"+stitle+":"+str(crawlerCount).zfill(3))
            batch.append(command)
        if batch == []:
            continue
        else:    
            commands[prob] = batch 



    # In[16]:


    f = open("/Users/eanzero/KOE_project/crawlerCount.txt",mode="w",encoding="utf=8")
    fi = open("/Users/eanzero/KOE_project/crawlerInfo.txt",mode="a",encoding="utf=8")
    furl = open("/Users/eanzero/KOE_project/crawlerURL.txt",mode="a",encoding="utf=8")
    f.write(str(crawlerCount))
    for i in infolist:
        fi.write(i+"\n")
    for big in bigProbs:
        for small in bigProbs[big][1]:
            furl.write(big+"#"+small+"#"+bigProbs[big][1][small]+"\n")
    f.close()
    fi.close()
    furl.close()


    # In[ ]:


    if commands == {}:
        time.sleep(22800) 
    else:    
        for command in commands:
            for i in commands[command]:
                subprocess.run(i,shell=True)
        time.sleep(22800) 