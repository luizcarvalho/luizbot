# from 
# https://www.amazon.com.br/gp/product/B006I1M8ZU/ref=as_li_ss_tl?ie=UTF8&linkCode=sl1&tag=promocoesdo0c-20&linkId=7c7dad311241fb4488c7e1f76a50cedc&language=pt_BR
# https://www.amazon.com.br/gp/product/B07YMBFYHF/ref=ppx_yo_dt_b_asin_title_o00_s00?ie=UTF8&psc=1
# https://www.amazon.com.br/gp/product/B07ZZW745X/ref=s9_acss_bw_cg_adpagepr_1a1_w?pf_rd_m=A3RN7G7QC5MWSZ&pf_rd_s=merchandised-search-2&pf_rd_r=V9PCRCPPVAME3335TBD2&pf_rd_t=101&pf_rd_p=bb0ebf1f-dbd0-4596-8e9a-4adfc14480bd&pf_rd_i=17387223011
# https://www.amazon.com.br/gp/product/B07ZZW745X


# TO

# https://www.amazon.com.br/gp/product/B006I1M8ZU/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B006I1M8ZU&linkCode=as2&tag=luizcarvalho-20&linkId=dd9ae4f006af7f5ccdda47566aee4b4d


class Amazon
  BASE_URL = 'https://www.amazon.com.br/gp/product/'
  AFL_SUFIX = '/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B006I1M8ZU&linkCode=as2&tag=luizcarvalho-20'

  def initialize(link)
    @original_link = link
  end

  def self.amazon_url?(url)
    url[/amazon/]
  end

  def convert_link
    "#{BASE_URL}#{product_id}#{AFL_SUFIX}"
  end

  def product_id
    @original_link.match(/(?:product|dp)\/(\w+)/)&.captures&.first
  end
end
