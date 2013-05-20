# -*- encoding: utf-8 -*-

#自定义异常:  
class ShortInputException(Exception):  
    def __init__(self,length,atleast):  
        Exception.__init__(self)  
        self.length=length  
        self.atleast=atleast  

try:  
    s=raw_input('请输入一些东西：')  
    if len(s)<3:  
        raise ShortInputException(len(s),3)     #触发自定义异常  
except EOFError:  
    print '\n为什么要强制结束？'  
except ShortInputException,x:  
    print '遇到ShortInputException异常，输入的长度是%d,\
触发至少要输入位数是%d'%(x.length,x.atleast)  
else:  
    print '没有异常被捕获。'  
finally:  
    print '无论是否异常都要执行这个语句！'  