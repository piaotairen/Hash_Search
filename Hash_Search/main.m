//
//  main.m
//  Hash_Search
//
//  Created by Zihai on 16/5/6.
//  Copyright © 2016年 Zihai. All rights reserved.
//

/**
 *
 #哈希查找是使用给定数据构造哈希表，然后在哈希表上进行查找的一种算法。先给定一个值，然后根据哈希函数求得哈希地址，再根据哈希地址查找到要找的元素。
 
 #哈希查找是通过数据元素的存储地址进行查找的一种算法。
 
 ## 算法步骤：
 　　
 （1）用给定的哈希函数构造哈希表。
 　　
 （2）根据选择的冲突处理方法解决地址冲突。
 　　
 （3）在哈希表的基础上执行哈希查找。
 
 以下代码是：根据提示输入学生信息，然后输入查找学生的学号，如果有的话，输出学生姓名和位置，如果没有的话，提示没有该学生的信息。
 */


#import <Foundation/Foundation.h>

#define Hash_MAX 20

typedef struct
{
    int num;
    char name[20];
} ElemType; //定义查找的节点元素

typedef struct
{
    ElemType *elem;
    int count;
    int sizeindex;
} HashTable; //定义哈希表

int hash(int num) //定义哈希函数
{
    int p;
    p = num % 5;
    return p;
}

void InitHash(HashTable *H)
{
    H -> elem = (ElemType *)malloc(Hash_MAX * sizeof(ElemType));
    H -> count = 0;
    H -> sizeindex = Hash_MAX;
    for (int i = 0; i < Hash_MAX; i++) {
        H -> elem[i].num = 0; //初始化，使hashSearch()函数能判断到底有没有元素在里面
    }
}

int hashSearch(HashTable H, int key, int *p)
{
    int c = 0;
    *p = hash(key);
    while (H.elem[*p].num!=key && H.elem[*p].num!=0) { //通过二次探测再散列解决冲突
        c = c + 1;
        if (c%2 == 1) {
            *p = *p + (c+1)*(c+1)/4;
        }
        else
        {
            *p = *p - (c*c)/4;
        }
    }
    if (H.elem[*p].num == key) {
        return 1;
    }
    else
    {
        return 0;
    }
}

void insertHash(HashTable *H, ElemType e) //如果查找不到就插入元素
{
    int p;
    hashSearch(*H, e.num, &p);
    H -> elem[p] = e;
    ++H -> count;
}

int main(int argc, const char * argv[])
{
    
    @autoreleasepool {
        
        HashTable H;
        int p, key;
        ElemType e;
        InitHash(&H);
        for (int i = 0; i < 3; i++)
        {
        loop:printf("请输入第%d个学生的学号 ", i+1);
            scanf("%d", &e.num);
            
            if (!hashSearch(H, e.num, &p)) {
                printf("输入第%d个学生名字 ", i+1);
                scanf("%s", e.name);
                insertHash(&H, e);
            }
            else
            {
                printf("该学号已经存在");
                goto loop;
            }
            
        }
        
        printf("请输入您要查找的学生学号： ");
        scanf("%d", &key);
        if (hashSearch(H, key, &p)) {
            printf("查找成功！学生的姓名是%s ",H.elem[p].name);
            printf("学生所在表中的位置是%d ", p);
        }
        else
        {
            printf("您要查找的学生不存在！ ");
        }
        
    }
    return 0;
}


