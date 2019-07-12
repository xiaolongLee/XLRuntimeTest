//
//  ViewController.m
//  XLRuntimeTest
//
//  Created by Mac-Qke on 2019/7/12.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Library.h"
#import "NSObject+XLAddAttribute.h"
#import <objc/runtime.h>
#import <objc/message.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self test2];
    
    NSObject *person = [NSObject new];
    person.name = @"bruceLee";
    
    [self test3];
}

- (void)test1{
    //// OC代码:
    [Person coding];
    
    //运行时 runtime 会将它转化成 C 语言的代码:
   // objc_msgSend(Person,@selector(coding));
    
    //相关函数
    
    // 遍历某个类所有的成员变量
   // class_copyIvarList(<#Class  _Nullable __unsafe_unretained cls#>, <#unsigned int * _Nullable outCount#>)
    
    
    //遍历某个类所有的方法
  //  class_copyMethodList(<#Class  _Nullable __unsafe_unretained cls#>, <#unsigned int * _Nullable outCount#>)
    
    //获取指定名称的成员变量
  //  class_getInstanceVariable(<#Class  _Nullable __unsafe_unretained cls#>, <#const char * _Nonnull name#>)
    
    //获取成员变量名
  //  ivar_getName(<#Ivar  _Nonnull v#>)
    
    //获取成员变量类型编码
//    ivar_getTypeEncoding(<#Ivar  _Nonnull v#>)

    
    //获取某个对象成员变量的值
//    object_getIvar(<#id  _Nullable obj#>, <#Ivar  _Nonnull ivar#>)
    
    //设置某个对象成员变量的值
//    object_setIvar(<#id  _Nullable obj#>, <#Ivar  _Nonnull ivar#>, <#id  _Nullable value#>)
    
    //给对象发送消息
//    objc_msgSend()

    
}

//相关应用
/*
  1更改属性
  2动态添加属性
  3动态添加方法
  4交换方法的实现
  5拦截并替换方法
  6在方法上增加额外功能
  7归档解档
  8字典模型转换
 
 */


//1.更改属性 用 runtime 修改一个对象的属性值
- (void)test2 {
    unsigned int count = 0;
    // 动态获取类中的所有属性(包括私有)
    Ivar *ivar = class_copyIvarList([Person class], &count);
    //遍历属性找到对应字段
    for (int i = 0; i < count; i++) {
        Ivar tempIvar = ivar[i];
        const char *varChar = ivar_getName(tempIvar);
        NSString *varString = [NSString stringWithUTF8String:varChar];
        if ([varString isEqualToString:@"_name"]) {
            //修改对应的字段值
            object_setIvar([Person new], tempIvar, @"更改属性值成功");
            break;
        }
    }
    
}

//SEL只是描述了一个方法的格式，如果把方法名理解成第一个标签，SEL就是描述一种由几个标签构成的方法，更偏向于c里的函数声明，SEL并不会指向方法。
//IMP应该是Implement缩写，表示指向方法的实现地址，可通过IMP来调用方法。
 //typedef id (*IMP)(id, SEL, ...);
//IMP 是一个函数指针，这个被指向的函数包含一个接收消息的对象id(self  指针), 调用方法的选标 SEL (方法名)，以及不定个数的方法参数，并返回一个id。也就是说 IMP 是消息最终调用的执行代码，是方法真正的实现代码 。我们可以像在Ｃ语言里面一样使用这个函数指针。实际根据SEL来调用方法的过程是选通过SEL在类里找到对应的IMP然后由IMP去调用方法。[Obj methodForSelector:@selector(selector:)];[Obj instanceMethodForSelector:@selector(selector:)];

//3 动态添加方法
- (void)test3{
    Person *person = [Person new];
    /*
       动态添加 coding 方法
       (IMP)codingOC 意思是 codingOC 的地址指针
     "v@" 意思是，v 代表无返回值 void ，如果 i 代表 int ； @代表 id sel; : 代表 SEL _cmd;
     "v@:@@"意思是。两个参数的没有返回值
     */
    
    class_addMethod([person class], @selector(running), (IMP)runningOC, "v@:");
    // 调用 running 方法响应事件
    if ([person respondsToSelector:@selector(running)]) {
        [person performSelector:@selector(running)];
        NSLog(@"添加方法成功");
    }else{
        NSLog(@"添加方法失败");
    }
    
    
}

void runningOC(id self,SEL _cmd){
    NSLog(@"添加方法成功");
}

//4 交换方法的实现

- (void)test4{
    Person *person = [Person new];
    Method oriMethod = class_getInstanceMethod(person.class, @selector(coding));
    
    Method curMethod = class_getInstanceMethod(person.class, @selector(eating));
    
    method_exchangeImplementations(oriMethod, curMethod);
}

//5 拦截并替换方法
- (void)test5{
    Person *person = [Person new];
    Library *lib = [Library new];
    
    Method oriMethod = class_getInstanceMethod(person.class, @selector(changeMethod));
    Method curMethod = class_getInstanceMethod(lib.class, @selector(libraryMethod));
    method_exchangeImplementations(oriMethod, curMethod);
}


@end
