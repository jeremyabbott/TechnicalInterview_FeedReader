﻿using System;
using System.Web;
using System.Data;
using System.Linq;
using System.Linq.Expressions;
using System.Collections.Generic;
using System.Globalization;
using System.Data.SqlClient;

namespace FeedReader.Models
{
    public class RssFeedReader
    {
         Dictionary<string, List<RssArticle>> rssMap = new Dictionary<string, List<RssArticle>>();

         public Dictionary<string, List<RssArticle>> ReadSubscribedFeeds(string UserId)
         {
             List<RssFeed> subscribedFeeds = LoadSubscribedFeeds(UserId);

             foreach(RssFeed feed in subscribedFeeds){
                 List<RssArticle> album = ReadFeedForChannel(feed.Link);
                 rssMap.Add(feed.Title, album);
             }

             return rssMap;
         }


         private List<RssArticle> ReadFeedForChannel(string Url)
         {
             List<RssArticle> album = new List<RssArticle>();
             //Read the channel feed
             return album;
         }

         public List<RssFeed> LoadSubscribedFeeds(string UserId)
         {
             List<RssFeed> subbedFeeds = new List<RssFeed>();

             ApplicationDbContext db = new ApplicationDbContext();

             //Write the query to be used
             string query = "SELECT * FROM RssFeeds WHERE UserId = @UserId";

             //Set the parameters
             SqlParameter userParam = new SqlParameter("UserId", UserId);
             object[] parameters = new object[] { userParam };

             IEnumerable<RssFeed> feeds = db.RssFeeds.SqlQuery(query, parameters);

             foreach(RssFeed feed in feeds){
                 subbedFeeds.Add(feed);
             }

             return subbedFeeds;
         }
         
    }

    
}