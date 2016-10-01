﻿using FeedReader.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Web.Mvc;
using System.Xml;
using System.Xml.Linq;
using System.Linq;
using FeedReader.Models.Services;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using FeedReader.Models.Helpers;

namespace FeedReader.Controllers
{
    [Authorize]
    public class HomeController : Controller
    {
        public ActionResult Index()
        {    
            return View();
        }

        [HttpGet]
        public ActionResult GetUserRssFeeds()
        {


            return null;
        }

        [HttpPost]
        public ActionResult AddRssFeed(string rssFeedUrl)
        {
            RssFeedDataHelper feedDataHelper = new RssFeedDataHelper();
            UserDataHelper userDataHelper = new UserDataHelper();
            String message = "";
            bool error = false;

            ApplicationUser applicationUser = userDataHelper.retireveUserFromDb(User.Identity.GetUserId());
            RssFeed rssFeed = feedDataHelper.retrieveRssFeedFromDb(rssFeedUrl);            

            //If null it means this is a feed we haven't saved before
            if (rssFeed == null)
            {   
                //Retrieve rss feed from url and save to database
                RssFeedService rssFeedService = new RssFeedService();
                rssFeed = rssFeedService.RetrieveRssFeed(rssFeedUrl);
                feedDataHelper.saveRssFeed(rssFeed);
            }

            UserRssFeed userRssFeed = feedDataHelper.retireveUserRssFeedFromDb(rssFeed, applicationUser);

            //If UserRssFeed is null we need to create a new one and save to database
            if (userRssFeed == null)
            {
                //save userRssFeed to database           
                userRssFeed = new UserRssFeed
                {
                    UserId = applicationUser.Id,
                    RssFeedId = rssFeed.RssFeedId
                };
                feedDataHelper.saveUserRssFeed(userRssFeed);

                message = String.Format("Successfully added Rss Feed: \"{0}\".", rssFeed.Title);
            }
            else //This means they have already added the Rss Feed
            {
                error = true;
                message = String.Format("You have already added Rss Feed: \"{0}\".", rssFeed.Title);
            }                

            return Json(new {error=error, message=message});
        }
    }
}