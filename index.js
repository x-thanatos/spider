const agent = require('superagent')
const cheerio = require('cheerio')
const async = require('async')

const HOST = 'http://tl.cyg.changyou.com/goods/selling'
console.log('爬虫程序开始运行......')
// 第一步，发起getData请求，获取所有4星角色的列表
agent
    .get(HOST)
    .end(function(err, res){
        console.log(res.text)
        // 并发遍历heroes对象
        // async.mapLimit(heroes, 1,
        //     function (hero, callback) {
        //         // 对每个角色对象的处理逻辑
        //         var heroId = hero[0]	// 获取角色数据第一位的数据，即：角色id
        //         fetchInfo(heroId, callback)
        //     },
        //     function (err, result) {
        //         console.log('抓取的角色数：' + heroes.length)
        //     }
        // )
    })
// 获取角色信息
var concurrencyCount = 0 // 当前并发数记录
var fetchInfo = function(heroId, callback){
    concurrencyCount++
    // console.log("...正在抓取"+ heroId + "...当前并发数记录：" + concurrencyCount)
    // 根据角色ID，进行详细页面的爬取和解析
    agent
        .get('http://wcatproject.com/char/' + heroId)
        .end(function(err, res){
            // 获取爬到的角色详细页面内容
            var $ = cheerio.load(res.text,{decodeEntities: false})
            // 对页面内容进行解析，以收集队长技能为例
            console.log(heroId + '\t' + $('.leader-skill span').last().text())
            concurrencyCount--
            callback(null, heroId)
        })

}