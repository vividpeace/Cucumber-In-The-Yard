def init
  super
  sections.push :namespace
  @namespace = object

end

def namespace
  erb(:namespace)
end

def all_features_by_letter
  hash = {}
  objects = features
  objects = run_verifier(objects)
  objects.each {|o| (hash[o.value.to_s[0,1].upcase] ||= []) << o }
  hash.values.each {|v| v.sort! {|a,b| b.value.to_s <=> a.value.to_s } }
  hash
end

def all_scenarios_by_letter
  hash = {}
  objects = scenarios
  objects = run_verifier(objects)
  objects.each {|o| (hash[o.value.to_s[0,1].upcase] ||= []) << o }
  hash.values.each {|v| v.sort! {|a,b| b.value.to_s <=> a.value.to_s } }
  hash
end

def all_directories_by_letter
  hash = {}
  objects = feature_directories
  objects = run_verifier(objects)
  objects.each {|o| (hash[o.value.to_s[0,1].upcase] ||= []) << o }
  hash.values.each {|v| v.sort! {|a,b| b.value.to_s <=> a.value.to_s } }
  hash
end

def feature_directories
  @feature_directories ||= Registry.all(:featuredirectory)
end

def features
  @features ||= Registry.all(:feature)
end

def scenarios
  @scenarios ||= Registry.all(:scenario).reject {|s| s.background? }
end

def steps
  @steps ||= Registry.all(:step)
end

def tags
  @tags ||= Registry.all(:tag).sort {|a,b| a.value.to_s <=> b.value.to_s }
end
