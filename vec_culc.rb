#!/usr/bin/ruby
# -*- coding: utf-8 -*-

# 2つのベクトルの類似度を返します
# return -1 (180 deg) ~ 1 (0 deg)
def calc_cosine_scale(vector1, vector2)
    
    # vector の正規化
    vector1 = normalize_vector(vector1)
    vector2 = normalize_vector(vector2)

    # calc inner product
    inner_product = 0

    word_list = (vector1.keys & vector2.keys)
    word_list.each {|word|
        inner_product += vector1[word] * vector2[word]
    }

    # calc each vector norm
    vector1_norm = 0
    vector2_norm = 0

    vector1.each {|key, value|
        vector1_norm += value * value
    }
    vector1_norm = Math::sqrt(vector1_norm)

    vector2.each {|key, value|
        vector2_norm += value * value
    }
    vector2_norm = Math::sqrt(vector2_norm)
    
    if vector1_norm * vector2_norm == 0
        cos_scale = 0.0
    else
        cos_scale = inner_product / (vector1_norm * vector2_norm)
    end
    

    return cos_scale
end

def normalize_vector (vec)
  sum = vec.inject(0) { |sum, (k, v)| sum += v.to_f }
  return vec.inject(Hash.new(0)) { |h, (k, v)| h[k] = v/sum; h }
end

if $0 == __FILE__

  ### Example
  v1 = {
    'music' => 1.0,
    'sports' => 2.0,
    'cinema' => 3.0,
  }

  v2 = {
    'music' => 1.0,
    'sports' => 2.0,
    'cinema' => 3.0,
  }

  puts "cos類似度: #{calc_cosine_scale(v1, v2)}"
end


