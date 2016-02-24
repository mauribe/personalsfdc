public class UtilChatter {
//UtilChatter uc = new UtilChatter();
    public UtilChatter() {
		//postFeed('00Q24000005pDyL','message post');   
        PostFeedMention('00524000001qSl7','00Q24000005pDyL',' Could you take a look?');
    }
    
    //Post a Feed Element
    public static void postFeed(id vsubjectId, string vMessage) {
        ConnectApi.FeedElement feedElement =
        ConnectApi.ChatterFeeds.postFeedElement(Network.getNetworkId(), vsubjectId,
        ConnectApi.FeedElementType.FeedItem, vMessage);
    }
    
    public static void getFeed(id vuserid) {
        
        ConnectApi.FeedElementPage fep =
        ConnectApi.ChatterFeeds.getFeedElementsFromFeed(Network.getNetworkId(),
        ConnectApi.FeedType.UserProfile, vuserid);
        
    }
    
    public static void PostFeedMention(id vuserid,id vrecordid, string vMessage) {
        ConnectApi.FeedItemInput feedItemInput = new ConnectApi.FeedItemInput();
        ConnectApi.MentionSegmentInput mentionSegmentInput = new ConnectApi.MentionSegmentInput();
        ConnectApi.MessageBodyInput messageBodyInput = new ConnectApi.MessageBodyInput();
        ConnectApi.TextSegmentInput textSegmentInput = new ConnectApi.TextSegmentInput();
        messageBodyInput.messageSegments = new List<ConnectApi.MessageSegmentInput>();
        mentionSegmentInput.id = vuserid;
        messageBodyInput.messageSegments.add(mentionSegmentInput);
        textSegmentInput.text = vMessage;
        messageBodyInput.messageSegments.add(textSegmentInput);
        feedItemInput.body = messageBodyInput;
        feedItemInput.feedElementType = ConnectApi.FeedElementType.FeedItem;
        feedItemInput.subjectId = vrecordid;
        ConnectApi.FeedElement feedElement =
        ConnectApi.ChatterFeeds.postFeedElement(Network.getNetworkId(), feedItemInput, null);
    }
    
}