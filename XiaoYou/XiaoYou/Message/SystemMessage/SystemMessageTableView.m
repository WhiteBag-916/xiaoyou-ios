//
//  SystemMessageTableView.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/20.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SystemMessageTableView.h"
#import "NormalSystemMessageTableViewCell.h"
#import "ApplySuccessSystemMessageTableViewCell.h"

@interface SystemMessageTableView ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray * dataSouceArr;

@end

@implementation SystemMessageTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = NO;
        _dataSouceArr = [@[@{@"text":@"南开大学欢迎你，为你开天辟地，希望咱们",@"type":@"normal"},@{@"text":@"你说你爱了不该爱的人你的心中满是伤痕，你说你犯了不该犯的村，心中满是悔恨，你说你尝遍了生活的苦，找不到可以倾诉的人，你说你感到万分沮丧，又开始怀疑人生，造势到伤心总是难免的，你又何苦一往情深",@"type":@"normal"},@{@"text":@"22日20时56分，润兴化工发生一起分离器着火爆炸事故。来自淄博市官方微博的消息称，截至23日1时50分，明火已经扑灭。桓台县政府新闻办介绍，事故共造成1死9伤，其中死者是在清理现场时发现的，系工厂职工。具有讽刺意味的是，在天津港爆炸事件之后，全国各地均开展了安全生产大检查，淄博也不例外。8月15日，淄博市安全生产委员会印发了《全面开展安全生产大检查深化“打非治违”和专项整治工作方案》的红头文件。(《第一财经日报》8月24日)",@"type":@"normal"},@{@"text":@"您已经加入足球社啦，去看看?",@"type":@"aaa"},@{@"text":@"天津港爆炸火灾事件",@"type":@"normal"},@{@"text":@"淄博润兴化工厂的着火爆炸事故，较之于天津港爆炸火灾事故，无论在威力上还是在受灾程度 上都很难同日而语，因此，当全国媒体与网友的目光聚集在天津之时，淄博的这起化工厂爆炸事故很难再有强烈的反响。可是，小事故也是事故，如果说天津爆炸事 故撕掉了生产安全的底裤，则淄博润兴化工厂爆炸事故也可以管中窥豹，并成为反面教材。况且，对于这样两起事故，却也有着相同的桥段与情节——之前都有过安 全检查，包括被安全部门约谈。可是，假如约谈和走马观花式的检查真得有实际作用，相信淄博润兴化工厂的爆炸也不会发生。",@"type":@"normal"},@{@"text":@"总有一种检查叫做“走后就发生安全事故”；总有一种安全事故发生在“安全检查刚刚结束之 后”。西方谚语曾教育我们，一个人很难踏入同一条河流，但是，对于我国的安全事故而言，却总是重复着这样的雷人事故和故事。于是，我们不得不反思，这样的 检查和约谈到底能够起到什么样的作用？我们又该如何从根本上在最大程度上防范此类事故再次发生？",@"type":@"normal"},@{@"text":@"笔者认为，灾难后的应景式安全检查虽然也有必要开展，但是毕竟对于“百密一疏”的安全事 故起不到根本上的遏制作用。而要剔除安全事故的隐患并形成真正的警醒，当要更加注重“两头”工作。一是，任何一个化工厂的设立与选址，无论是安评，还是环 评，无论是政府的安全监管，还是对于企业自身的防范，都应该走最严格的程序。要严格遵守《安全生产法》以及《危险化学品经营许可证管理办法》，更要相关安 评和环评机构严格履职，在生产经营过程中，还要加强对工作人员的安全业务培训，真正做到把事故苗头扼杀在萌芽状态。",@"type":@"normal"},@{@"text":@"前强化程序正义以预防，事后强化问责和党政同责，才能最大程度上避免再一次发生类似的 事故。对比之下，样板戏化的全国安全大检查，可能存在“会议落实会议”、“文件落实文件”、“约谈落实约谈”的嫌疑。因此，希望淄博爆炸事故后同样能有严 厉的问责和最真实的调查，同样能给社会一个负责任的、经得起历史和人民检验的结论。",@"type":@"normal"},@{@"text":@"您已经加入魔方社啦，去看看?",@"type":@"bbb"},@{@"text":@"8月17日至21日，山东省督察组深入淄博市督察安全生产工作。不料，督察组前脚刚走，桓台就发生了爆炸事件....唉",@"type":@"normal"},@{@"text":@"8月17日至21日，山东省督察组深入淄博市督察安全生产工作。不料，督察组前脚刚走，桓台就发生了爆炸事件....唉次发生类似的 事故。对比之下，样板戏化的全国安全大检查，可能存在“会议落实会议”、“文件落实文件”次发生类似的 事故。对比之下，样板戏化的全国安全大检查，可能存在“会议落实会议”、“文件落实文件”次发生类似的 事故。对比之下，样板戏化的全国安全大检查，可能存在“会议落实会议”、“文件落实文件”次发生类似的 事故。对比之下，样板戏化的全国安全大检查，可能存在“会议落实会议”、“文件落实文件”次发生类似的 事故。对比之下，样板戏化的全国安全大检查，可能存在“会议落实会议”、“文件落实文件”次发生类似的 事故。对比之下，样板戏化的全国安全大检查，可能存在“会议落实会议”、“文件落实文件”次发生类似的 事故。对比之下，样板戏化的全国安全大检查，可能存在“会议落实会议”、“文件落实文件”次发生类似的 事故。对比之下，样板戏化的全国安全大检查，可能存在“会议落实会议”、“文件落实文件”次发生类似的 事故。对比之下，样板戏化的全国安全大检查，可能存在“会议落实会议”、“文件落实文件”次发生类似的 事故。对比之下，样板戏化的全国安全大检查，可能存在“会议落实会议”、“文件落实文件”",@"type":@"normal"}] mutableCopy];
        [self registerClass:[NormalSystemMessageTableViewCell class] forCellReuseIdentifier:kNormalSystemMessageTableViewCell];
        [self registerClass:[ApplySuccessSystemMessageTableViewCell class] forCellReuseIdentifier:kApplySuccessSystemMessageTableViewCell];
    }
    return self;
}

-(void)refreshTableView:(NSMutableArray *) dataSouceArr
{
    [self reloadData];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSouceArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = _dataSouceArr[indexPath.row];
    if ([dic[@"type"] isEqualToString:@"normal"])
    {
        NormalSystemMessageTableViewCell * cell = [self dequeueReusableCellWithIdentifier:kNormalSystemMessageTableViewCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setCellInfo:_dataSouceArr[indexPath.row]];
        
        return cell;
    }
    else
    {
        ApplySuccessSystemMessageTableViewCell * cell = [self dequeueReusableCellWithIdentifier:kApplySuccessSystemMessageTableViewCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setCellInfo:_dataSouceArr[indexPath.row]];
        
        return cell;
    }
    
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSDictionary * dic = _dataSouceArr[indexPath.row];
    
    UIFont * font = CONTENT_FONT(12);
    CGSize titleSize = [dic[@"text"] sizeWithFont:font
                       constrainedToSize:CGSizeMake(SCREEN_WIDTH - 103, MAXFLOAT)];
    if (titleSize.height < 25)
    {
        if ([dic[@"type"] isEqualToString:@"normal"])
        {
            return 70;
        }
        else
        {
            return 90;
        }
        
    }
    else
    {
        if ([dic[@"type"] isEqualToString:@"normal"])
        {
             return titleSize.height + 65;
        }
        else
        {
             return 90;
        }
        
    }
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  
}

@end
