
'use strict';

const { utils } = require('surgio');

const myCommonFilter = utils.discardKeywords(['剩余流量', '过期时间', '官网', 'elegram']);
const myNhkFilter = utils.mergeFilters([utils.discardKeywords(['hkt', 'HKT', '香港']), myCommonFilter], true);
const myCheapFilter = utils.mergeFilters([utils.discardKeywords(['3x']), myCommonFilter], true);

/**
 * 使用文档：https://surgio.royli.dev/
 */
module.exports = {
  /**
   * 远程片段
   * 文档：https://surgio.royli.dev/guide/custom-config.html#remotesnippets
   */
  remoteSnippets: [
    {
      name: 'advertising',
      url: 'https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Guard/Advertising.list'
    },
    {
      name: 'advertisingplus',
      url: 'https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Guard/AdvertisingPlus.list'
    },
    {
      name: 'hijacking',
      url: 'https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Guard/Hijacking.list'
    },
    {
      name: 'privacy',
      url: 'https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Guard/Privacy.list'
    },
    {
      name: 'global',
      url: 'https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Global.list'
    },
    {
      name: 'twitter',
      url: 'https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Extra/Twitter.list',
    },
    {
      name: 'streamingse',
      url: 'https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/StreamingMedia/StreamingSE.list',
    },
    {
      name: 'streamingcn',
      url: 'https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/StreamingMedia/StreamingCN.list',
    },
    {
      name: 'china',
      url: 'https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/China.list',
    },
  ],
  customFilters: {
    commonFilter: myCommonFilter,
    nhkFilter: myNhkFilter,
    cheapFilter: myCheapFilter,
  },
  artifacts: [
    /**
     * Clash
     */
    {
      name: 'Clash.yaml',
      template: 'clash',
      provider: 'provider',
      customParams: {
        dns: true,
      }
    },
  ],
};
