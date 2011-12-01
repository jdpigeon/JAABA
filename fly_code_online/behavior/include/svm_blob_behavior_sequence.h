#ifndef  __SVM_STRUCT_API_BLOB_BEHAVIOR_SEQUENCE__
#define __SVM_STRUCT_API_BLOB_BEHAVIOR_SEQUENCE__

#include "svm_struct_api_behavior_sequence.h"

#include "../../fit_model.h"


class SVMBlobBehaviorSequence : public SVMBehaviorSequence {
  FitParams params;
 public:
  SVMBlobBehaviorSequence(FitParams *p, struct _BehaviorGroups *behaviors, int beh, SVMFeatureParams *sparams=NULL);

  static SVMFeatureParams AspectRatioParams();
  static SVMFeatureParams VelocityParams();
  static SVMFeatureParams MaxCurvatureParams();
  static SVMFeatureParams CurveParams();

  const char *get_base_feature_name(int ind);
  int num_frames(void *b);
  void load_from_bout_sequence(BehaviorBoutSequence *y, void *b);
  BehaviorBoutSequence *create_behavior_bout_sequence(void *b, BehaviorGroups *behaviors, bool build_partial_label);
  void load_behavior_bout_features(void *b, BehaviorBoutFeatures *feature_cache);
  void *load_training_example(const char *fname);
  void save_example(void *b, void *d, const char *fname);
  void free_data(void *d);
  char **load_examples(const char *fname, int *num);
  void save_examples(const char *fname, SAMPLE sample);
  char *getLabelName(void* d);
};

#endif
