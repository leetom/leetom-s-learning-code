/* 三种方法遍历二叉树 */
#include <stdio.h>
#include <stdlib.h>

//二叉树结点
typedef struct tree_node
{
    int data;            /* 数据 */
    struct tree_node *l_child,    /* 左子树 */
    *r_child;        /* 右子树 */
}tree_node,*bitree;

/* 先序创建二叉树 */
bitree create ()
{
    bitree root = NULL;        /* 根 */
    int num;            /* 序号 */

    printf ("input the num (0 for NULL): ");
    scanf ("%d", &num);
    /* 没有孩子 */
    if (num == 0)
    {
    return NULL;
    }
    else
    {
    root = (bitree) malloc (sizeof (tree_node));
    if (root == NULL)
    {
        printf ("Memory Not Enough! \n");
        exit(0);
    }

    root->data = num;       /* 创建数据 */
    root->l_child = create (); /* 递归创建左子树 */
    root->r_child = create (); /* 递归创建右子树 */
    }

    return root;
}
/* 先序遍历 */
void pre_order (bitree root)
{
    if (!root)
    {
    return;
    }
    else
    {
    printf ("%d ", root->data);
    pre_order (root->l_child);
    pre_order (root->r_child);
    }
}

/* 中序遍历 */
void in_order (bitree root)   
{
    if (!root)
    {
    return;
    }
    else
    {
    in_order (root->l_child);
    printf ("%d ", root->data);
    in_order (root->r_child);
    }
}

/* 后序遍历 */
void post_order (bitree root)
{
    if (!root)
    {
    return;
    }
    else
    {
    post_order (root->l_child);
    post_order (root->r_child);
    printf ("%d ", root->data);
    }
}
//////////////////////////////////////////////////
// The main() function
//////////////////////////////////////////////////
int main(int argc, char *argv[])
{
    bitree root = NULL;

    printf ("输入先序序列：\n");
    root = create ();

    printf ("先序遍历：\n");
    pre_order (root);
    printf ("\n");

    printf ("中序遍历：\n");
    in_order (root);
    printf ("\n");

    printf ("后序遍历：\n");
    post_order (root);
    printf ("\n");
    return 0;
}
