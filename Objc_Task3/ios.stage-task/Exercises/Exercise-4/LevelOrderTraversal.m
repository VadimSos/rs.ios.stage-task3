#import "LevelOrderTraversal.h"
#import <Foundation/Foundation.h>

// TreeNode structure
@interface TreeNode : NSObject
@property (nonatomic, strong) NSNumber *val;
@property (nonatomic, strong) TreeNode *left;
@property (nonatomic, strong) TreeNode *right;

- (instancetype)initWithValue:(NSNumber *)value;
@end

@implementation TreeNode
- (instancetype)initWithValue:(NSNumber *)value {
    self = [super init];
    if (self) {
        self.val = value;
        self.left = nil;
        self.right = nil;
    }
    return self;
}
@end

// Helper function to build tree from preorder array
TreeNode *buildTree(NSArray *tree, NSInteger *index) {
    if (*index >= tree.count || tree[*index] == [NSNull null]) {
        (*index)++;
        return nil;
    }
    
    TreeNode *node = [[TreeNode alloc] initWithValue:tree[*index]];
    (*index)++;
    node.left = buildTree(tree, index);
    node.right = buildTree(tree, index);
    
    return node;
}

// Function to perform level-order traversal
NSArray *levelOrderTraversal(TreeNode *root) {
    if (!root) return @[];
    
    NSMutableArray *result = [NSMutableArray array];
    NSMutableArray *queue = [NSMutableArray arrayWithObject:root];
    
    while (queue.count > 0) {
        NSInteger levelSize = queue.count;
        NSMutableArray *currentLevel = [NSMutableArray array];
        
        for (NSInteger i = 0; i < levelSize; i++) {
            TreeNode *node = queue[0];
            [queue removeObjectAtIndex:0];
            [currentLevel addObject:node.val];
            
            if (node.left) {
                [queue addObject:node.left];
            }
            if (node.right) {
                [queue addObject:node.right];
            }
        }
        
        [result addObject:[currentLevel copy]];
    }
    
    return [result copy];
}

// Convert pre-order array to level-order traversal
NSArray *LevelOrderTraversalForTree(NSArray *tree) {
    NSInteger index = 0;
    TreeNode *root = buildTree(tree, &index);
    return levelOrderTraversal(root);
}

