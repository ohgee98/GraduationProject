#!/usr/bin/env python
# coding: utf-8

# In[ ]:


import sys
import os
import re
from bs4 import BeautifulSoup as BS
import ssl, urllib
import traceback
import time
import random
import subprocess
from urllib import request

def readHashTable(big,small,lh):
    big = big.replace("/","_")
    big = big.replace(" ","+")
    small = small.replace("/","_")
    small = small.replace(" ","+")
    if os.path.exists("/usr/src/app/Users/eanzero/KOE_project/meta/" + big + "/" + small + "/url_list.txt"):
        f = open("/usr/src/app/Users/eanzero/KOE_project/meta/" + big + "/" + small + "/url_list.txt",mode="r",encoding="UTF-8")
        while True:
            line = f.readline()
            if not line:
                break
            line = line.strip()
            print("파일에서 확인된 주소: " + line)
            lh[line] = True
        f.close()
        return lh
    return lh

def writeHashTable(big,small,lh):
    big = big.replace("/","_")
    big = big.replace(" ","+")
    small = small.replace("/","_")
    small = small.replace(" ","+")
    simCheck = False
    f = open("/usr/src/app/Users/eanzero/KOE_project/meta/" + big + "/" + small + "/url_list.txt",mode="a",encoding="UTF-8")
    for i in lh:
        print("주소 등록: " + i + " | "+ str(lh.get(i)))
        if lh[i] == False:
            simCheck = True
            f.write(i+"\n")
            lh[i] = True
    
    if simCheck==True:
        big = big.replace("(","^")
        big = big.replace(")","@")
        small = small.replace("(","^")
        small = small.replace(")","@")
        subprocess.run("java -jar calSim.jar "+big+" "+small,shell=True)
        print("calSim 실행완료")
    f.close()



def searchUsingKeyword(tar):
    time.sleep(random.uniform(3,10))
    base_url = "https://www.google.co.kr/search"
    target = tar
    values = { 'q': target,
              'oq': target, 'sourceid':'chrome','ie':'UTF-8', }
    hdr = {'User-Agent':'Mozilla/5.0'}
    query_string = urllib.parse.urlencode(values)
    totalUrl = base_url +'?'+ query_string
    print(totalUrl)
    req = urllib.request.Request(base_url +'?'+ query_string, headers=hdr)

    context = ssl._create_unverified_context()
    try:
        res = urllib.request.urlopen(req, context=context)
    except:
        print("searchUsingKeyword 에러발생: " + totalUrl)
        traceback.print_exc()
    html_data = BS(res.read(),'html.parser')
    return html_data

def openPage(url):
    time.sleep(random.uniform(3,10))
    hdr = {'User-Agent':'Mozilla/5.0'}
    req = urllib.request.Request(url, headers=hdr)

    context = ssl._create_unverified_context()
    try:
        res = urllib.request.urlopen(req, context=context)
        print("페이지 가져오기 성공: " + url)
    except:
        print("openPage 에러발생: " + url)
        traceback.print_exc()
    html_data = BS(res.read(),'html.parser')
    return html_data


def getCodePage(url):
    time.sleep(random.uniform(3,10))
    hdr = {'User-Agent':'Mozilla/5.0'}
    req = urllib.request.Request(url, headers=hdr)

    context = ssl._create_unverified_context()
    try:
        res = urllib.request.urlopen(req, context=context)
        html_data = BS(res.read(),'html.parser')
        return html_data
    except:
        print("getCodePage 에러발생: " + url)
        traceback.print_exc()
        return None

'''
def makeDirectory(big,small):
    big = big.replace("/","_")
    big = big.replace(" ","+")
    small = small.replace("/","_")
    small = small.replace(" ","+")
    if not os.path.exists("/usr/src/app/Users/eanzero/KOE_project/programmers/" + big + "/" + small):
        os.makedirs("/usr/src/app/Users/eanzero/KOE_project/programmers/" + big + "/" + small)
'''

def makeSearchKeyword(big,small):
    base_keyword = "site:tistory.com 프로그래머스"
    keyword = big + " " + small
    language = "Java"
    return base_keyword + " " + keyword + " " + language

def removeMark(strn):
    try:
        temp = [m.end() for m in re.finditer('}', strn)]
        last = temp.pop()
        result = strn[:last]
        return result
    except:
        result = "data is empty"
        return result

def removeComments(string):
    string = re.sub(re.compile("/\*.*?\*/",re.DOTALL ) ,"" ,string) # remove all occurrences streamed comments (/*COMMENT */) from string
    string = re.sub(re.compile("//.*?\n" ) ,"" ,string) # remove all occurrence single-line comments (//COMMENT\n ) from string
    return string

def getCodeFromCCT(cct):
    codelist = []
    for code in cct:
        child = code.findChildren("td")
        try:
            child[0].extract()
        except:
            print("이상한 인덱스 에러")
            return codelist
        removedtext = removeComments(removeMark(code.get_text()).strip())
        if "data is empty" not in removedtext:
            codelist.append(removedtext)
    return codelist

def getCodeFromCode(inputCode):
    codelist = []
    for code in inputCode:
        removedtext = removeComments(removeMark(code.get_text()).strip())
        if "data is empty" not in removedtext:
            codelist.append(removedtext)
    return codelist

def getCodeFromCM(code_mirror):
    codelist = []
    for code in code_mirror:
        removedtext = removeComments(removeMark(code.get_text()).strip())
        if "data is empty" not in removedtext:
            codelist.append(removedtext)
    return codelist

def findAllCode(html_data):
    totalList = []
    soup = html_data
    cct = soup.find_all("table",class_="colorscripter-code-table")
    code = soup.find_all("code")
    code_mirror = soup.find_all("div",class_="CodeMirror-code")

    totalList.append(getCodeFromCCT(cct))
    totalList.append(getCodeFromCode(code))
    totalList.append(getCodeFromCM(code_mirror))
    return totalList

def isURLinHash(t):
    if t in linkHash:
        print("주소 존재함: " + t)
        return True
    else:
        linkHash[t] = False
        return False

def getTitles(html_data):
    h3_list = html_data.find_all("h3")
    url = []
    for temp in h3_list:
        title = temp.parent
        tempStrn = title.get("href")
        tempStrn = tempStrn.replace("/url?q=","")
        firstANDindex = tempStrn.find("&")
        input_url = urllib.parse.unquote(tempStrn[0:firstANDindex])
        if not isURLinHash(input_url):
            url.append(input_url)
    return url

def getNextPage(html_data):
    nextPageKOR = html_data.select('a[aria-label="다음 페이지"]')
    nextPageEN = html_data.select('a[aria-label="Next page"]')
    if nextPageKOR:
        nextPage = nextPageKOR
    elif nextPageEN:
        nextPage = nextPageEN
    else:
        result = "NoPage"
        return result
    tempStrn = nextPage[0].get("href")
    result = "https://www.google.co.kr" + tempStrn
    return result


def replace_url(url):
    if "http://" in url:
        url = url.replace("http://", "")
    elif "https://" in url:
        url = url.replace("https://", "")
    url = url.replace("/","#")
    url = url.replace(":","$");# 링크에 :가 들어가는 경우 파일 저장 불가. 따라서 대체
    check = url.find("?")

    if str(check) != "-1":
        point = url.index("?")
        url = url[:point]

    result = urllib.parse.unquote(url)
    return result

def saveStringToFile(big,small,thisUrl,str_list):
    fileCount = 1
    big = big.replace("/","_")
    big = big.replace(" ","+")
    small = small.replace("/","_")
    small = small.replace(" ","+")
    for l in str_list:
        if l is not None:
            for c in l:
                f = open("/usr/src/app/Users/eanzero/KOE_project/programmers/" + big + "/" +                small + "/" + replace_url(thisUrl) + "_" + str(fileCount).zfill(2) + ".txt" , mode="w", encoding="UTF-8")
                f.write(c)
                f.close()
                fileCount = fileCount + 1


def circulation_titles(big,small,titles):
    big = big.replace("/","_")
    small = small.replace("/","_")
    for title in titles:
        print(title)
        if 'cfile' in title or '@' in title or title.endswith('.hwp') or title.endswith('.pdf') or title.endswith('.xlsx') or title.endswith('.xls'):
            print("파일을 다운로드 하는 주소라 건너 뛴다")
            continue
        getedPage = getCodePage(title)
        if getedPage is not None:
            codes = findAllCode(getedPage)
            saveStringToFile(big,small,title,codes)





linkHash = {}

big = sys.argv[1]
small = sys.argv[2]

big = big.replace("_","/")
big = big.replace("+"," ")
big = big.replace("^","(")
big = big.replace("@",")")
small = small.replace("_","/")
small = small.replace("+"," ")
small = small.replace("^","(")
small = small.replace("@",")")

print(big + " " + small)

soup = searchUsingKeyword(makeSearchKeyword(big,small))

linkHash = readHashTable(big,small,linkHash)

while True:
    time.sleep(random.uniform(3,10))
    nextPage = getNextPage(soup)
    titles = getTitles(soup)
    circulation_titles(big,small,titles)
    print("다음 탐색할 페이지: " + nextPage)
    if nextPage == "NoPage":
        print("마지막 페이지까지 탐색 완료/ 완료 페이지: " + lastPage)
        writeHashTable(big,small,linkHash)
        time.sleep(random.uniform(14400,50000))
        soup = searchUsingKeyword(makeSearchKeyword(big,small))
    else:
        time.sleep(random.uniform(15,20))
        soup = openPage(nextPage)
        lastPage = nextPage